Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37EEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9696120870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQBWyHJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9696120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbeKTRZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:25:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34856 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731443AbeKTRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:25:17 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so1994848itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 22:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i3PwowH+vLolCmpbpViKW5ox7LPqkilUaDWH43SyWCM=;
        b=pQBWyHJ+JyPqkCF9s7Fr40XVrww7wUYDiW3Ha4bBgGgyh4Vg3T3DKQt2uh0063q6Lz
         6l3UFNPoLYYWOL4kE17LnhDW4g5tIwtm3S0vmBv24lhYcmdlQ3mgIJHdHQZjr3OmpPdv
         yMUqnrMMvt4XKQwRF1wf3Q6FbfAluSIkl706G0JizUEbBB0ZO8UYePsZdYXyYfKVLcpW
         Dwl3vtev+6oK6IxGmMxEwpFLPpUcHQSEMpcB5E+sldWQw92Dhz0KaT199DWNPNPa4+ml
         Mj/X4m9ZikJ0koqI67jbxDL2DvL0rooobxL53sy3OYJwvATHZTZOdsrACkxosqDjlDo6
         ZLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i3PwowH+vLolCmpbpViKW5ox7LPqkilUaDWH43SyWCM=;
        b=ps8D8v3f2rPgPBxqBQPrH9OyYMXh80UXfA/WPmlA9c8pJ6whkUlESiSH42U6gj6VRb
         paR6bh33cN8txFjZ4wPIpfjfL8ox7yfU7RP+O28h2jUq5Z71hlE5NlVHMLSTnd8zwmwp
         72il1H/8pfvk9CbmFDiDxFKec6cPG/lccFj894m/vFWMjwWXhoQieKIYNK0iEQbAy5vL
         b+jhKL5aPLmp4AP8YcEk9q0RXCl4b1oIFPPmtwJAylg+8VtcoBPVVQbpXT/EGUs+agVr
         k0igrFSIinfXefRFDsUWfJg6Fyh6tPNj+m2Ma+sZKyq+xqwn5evvVxmCEMeqiiddd8Zm
         fVwQ==
X-Gm-Message-State: AA+aEWYHafJEo4lcScajDNCKuS2OGcthp2YyZkPPkT2Bfd703t/I7+Qv
        nf+eBhZq5GGg+6f6vxxZxWjIlwVC9SECvQRDZmf9Tg==
X-Google-Smtp-Source: AJdET5ePW7bS3yjeh6nKor3VPsW9kVVb6o86SXtbYzM8MMx4xXd6JQt+rwWNkE/Fr0csNi/0CcORJ7eZaHViuYxryxM=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr1083216itf.166.1542697063832;
 Mon, 19 Nov 2018 22:57:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 22:57:23
 -0800 (PST)
In-Reply-To: <20181117140356.GA29895@fieldses.org>
References: <000000000000222b58057a7d9f39@google.com> <9d9ad7f2781bf15af4bd6ccc9feee35c7cd17979.camel@kernel.org>
 <87bm6svhhl.fsf@notabene.neil.brown.name> <b49e02d54460c79c4e5472983f6b9390005881b8.camel@kernel.org>
 <CACT4Y+Z3zM0z9PScAKjyjspu35B-6OgTT_qEwc+AB_MFzJkL0A@mail.gmail.com>
 <87bm6pewnm.fsf@notabene.neil.brown.name> <CACT4Y+Ysn70kTSgp_KZ5aRGuiNK0wUcqbjAH8xBJ8MqV+mFyqQ@mail.gmail.com>
 <c76712278e2d7f5c4c8cfbab687a941bf493b0c6.camel@kernel.org> <20181117140356.GA29895@fieldses.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 20 Nov 2018 07:57:23 +0100
Message-ID: <CACT4Y+ag3mJNGUkjHQSyikT9xMJSjuY3fhSJ-2QH0eL1bTPhYw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in locks_delete_block
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.com>,
        syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 3:03 PM, Bruce Fields <bfields@fieldses.org> wrote:
> On Sat, Nov 17, 2018 at 08:33:27AM -0500, Jeff Layton wrote:
>> Thanks for the explanation, Dmitry. I've added the tag to the patch in
>> my tree. It should show up in linux-next soon.
>>
>> I still find it a little misleading to say that syzbot reported a bug
>> when it actually found a bug inside an earlier version of the patch, but
>> I'll just learn to get over it.
>
> The usual tag for someone that found a bug in an earlier version of a
> patch would be Reviewed-by:.  Is there any reason we can't use that
> here?  The "syzbot+..." email should be enough on its own, I can't see a
> reason why their scripts would need to require a particular tag.  Or
> maybe we could use Tested-by:, or some other tag made up for this case?
>
> I do worry that someone who sees "Reported-by:..." might for example
> mistakenly assume that it would help to backport that patch if they see
> a similar-looking oops.

I see. It may also be picked by scripts that detects patches that need
to be backported to stable because of the "Reported-by: syzbot" tag.
This is somewhat unfortunate.

There is no problem parsing another tag on syzbot side. Does Tested-by
look good to you? If it found a bug in the patch and then it was
fixed, Tested-by looks reasonable. And we also detect
Reported-and-tested-by already because that's what syzbot suggests
after it tested a proposed fix for a bug.

I am somewhat concerned how to spread this information across all
kernel developers. There is effectively no way to do this. We can't
expect people to read docs, they generally don't. I guess I just
document this at "See https://goo.gl/tpsmEJ for more information" and
then we can point other people there if/when this concern pops up
again.
