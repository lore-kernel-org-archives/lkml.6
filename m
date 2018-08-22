Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33216C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D22217D5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCbK58B3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D22217D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeHVEvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 00:51:38 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35031 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeHVEvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 00:51:38 -0400
Received: by mail-io0-f193.google.com with SMTP id w11-v6so261635iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 18:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqpQEXE05qP1ux+1Gs4WHgn0x+tzTapZgHZjxjwQaEM=;
        b=jCbK58B3dltJDiBHK/fXWV/284WdnovClJiLO4UZ8bmRIf3NLbAYnvPGhi7UOB6qSE
         49rUhRmQGMpibqiRG2R+ThsFv1/XRvNrgOlhVM0u/l2HM0cPjykhqIlSBHyw0la/B437
         OTA8bjNY9j6FsEBysf45fp5kp4ztNECzPUSxl3I7wyVJLAF01Unja4Re9BQsmDaxD3oV
         izNKaUIcyJlVFepomo61DzWY7DOjvAST5vZjgcOkorJW/mERZI2B+rnds+CddeclnrTU
         e61N6FBD8JT/2U33T/B9FIPGqCxrt8XCDRxfXakT82WTvW5t4ZxCNke1ZI4I9L9ZdS7T
         yZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqpQEXE05qP1ux+1Gs4WHgn0x+tzTapZgHZjxjwQaEM=;
        b=mcDYBxHQGDdb9GLf7EfpRtM9GawesVECUtb/O97VHz5mSVahm4suX5IsM4sQJgemFp
         0DGrKK5uUkmP2GTIonRZj/z1oDLi/I6A9JeLkVCFCuy9Kj0Mgi40eems5GgywbJTFBnc
         MGZpnn99rxXIE3xTNM1+CdL1YJJouxmzXlQ5pASCzQuFMaFFFsrbPEZojLPiu0p0BaGI
         tC6G0RcgUl8KP2GA1RM+VR22Y/nPK1rOt6SDIWDQkp+jGPRtHyJBhmhOezWldr0BwIyk
         PZAnl1gm2vxOC7YQePj8hEcNJt5ie7sW300atvxSpKVjxmGGS31eeuXkpwlZOk/66lqC
         26Uw==
X-Gm-Message-State: APzg51BB2AZz9pX10LqwMlbLyBL9CAwWHfumXO+vjR5ZvYx7rNoTVd9Z
        ljrJWceewPY7AuDTdIdUOMarf6BjPb9HkuG6Ya+tpg==
X-Google-Smtp-Source: ANB0VdYcIS4+7E9vK/9L8//MK547Mi1KEHlPYRTu4yT9McT4lBxT3ipb+FTIsK4P0PNtXmZIvi9HXE99a67NtigimXU=
X-Received: by 2002:a6b:2191:: with SMTP id h139-v6mr8768777ioh.240.1534901343807;
 Tue, 21 Aug 2018 18:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180816015724.GB2793@jagdpanzerIV> <20180815203226.2c7e48b2f9395d2772ecfcb2@linux-foundation.org>
 <20180816014835.GA2793@jagdpanzerIV> <20180814164523.e0fdeed962917e23062ef958@linux-foundation.org>
 <20180821160307.GA63897@google.com>
In-Reply-To: <20180821160307.GA63897@google.com>
From:   Peter Kalauskas <peskal@google.com>
Date:   Tue, 21 Aug 2018 18:28:51 -0700
Message-ID: <CAOxpCJ_gW=480c94XQR1kPjJEK+di-hYKMa_w78=iYwXFxCC6g@mail.gmail.com>
Subject: Re: [PATCH] zram: fix bug storing backing_dev
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 04:45:23PM -0700, Andrew Morton wrote:
> The changelog doesn't describe the end-user impact of the bug, which is
> very desirable when tagging a patch for -stable backporting.  Can we
> have that paragraph please?

The end-user impact is that echoing to writeback_dev would not cause it
to change. Would the following statement suffice?

  Without this change, it is not possible to change writeback_dev unless
  the tool used to do so does not include a newline character.  For
  example, 'echo -n' or 'printf' would work, but 'echo' would not work.

I can also include Sergey's description of the bug if that would be
helpful.


On Thu, Aug 16, 2018 at 10:48:35AM +0900, Sergey Senozhatsky wrote:
> On (08/14/18 16:45), Andrew Morton wrote:
> > >
> > > > > -     strlcpy(file_name, buf, len);
> > >
> > > This is quite interesting. The reason it worked before was the fact that
> > > strlcpy() copies 'len - 1' bytes, which is strlen(buf) - 1 in our case,
> > > so it accidentally didn't copy the trailing new line symbol. Which also
> > > means that "echo -n /dev/sdX" most likely was broken.
> > >
> >
> > I can't find the original email on lkml for some reason, but I
> > recreated the patch.
>
> Neither can I.
>

Sorry, I sent it to Minchan directly. I'll send PATCH v2 to lkml, if v2
is needed.


On Wed, Aug 15, 2018 at 08:32:26PM -0700, Andrew Morton wrote:
> On Thu, 16 Aug 2018 10:48:35 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>
> > > The implementation might be able to use strim() somehow.
> >
> > strim() trims white-spaces.
>
> Which includes \n.
>

The if statement is already used by comp_algorithm_store in zram_drv.c,
so perhaps it should remain the if statement for consistency. What do
you think, should I use strim or the if statement?
