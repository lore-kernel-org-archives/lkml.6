Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD4B2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BrD+JN/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD4B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeIFPyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:54:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35676 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIFPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:54:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so5134263pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zwO6JYpmwGP42vzVkOsx7sn91q9ORCEn+bx05q633ro=;
        b=BrD+JN/zbXett1ba+ymVxBxL1KRcoJEwwrrf28l1buzgr08mDc3TzncaSZBLo33Ddv
         4lLHhSUJL3EXqwXPCnbMejztu57Rutt0l0nHWIQiWatYyZhajagUEn8jfmfl+ai4mTHS
         scFMRuET1WkN3L+8wiWUDIXzHEYNHC/afLHp98ifjA/JH3PnpyLx9g3MvcMRZ2RWAgH+
         pz9Vz9+YEWcsX+soIJ03XmOwC7ggH+/qNPj7xqCDwJr2T/8cS/79m/asEKKHvlvu38HE
         2wS2gv4F/63lgkj3r/4REgU1gEY3x7vqigrFSH8Z20bCL6po19wtcHuQd5UUkAkVHWFf
         lyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zwO6JYpmwGP42vzVkOsx7sn91q9ORCEn+bx05q633ro=;
        b=Wz3tet7WInfatl3wBqUNGOuMP1AkSAjpvcvcXY6W8KciBkVheJ9yK/BAME/u0zdOnW
         q+xoMacIGajE5l0ev60/giGRDWfJcrm7zqGiNTSDf/CdAtXePRn2SUzQe4MEamtlqKcA
         XZoHliJs6MtfREAzG/emEiHcJP7QaWm6YtSMVjfVMC//sooLOX7uOcWd0Epr6J/a5qcz
         1+DkihfJK0xpdbmjsH8GuyPD1foyrHYbvOgKM50diLK7iKVYGdumb75aC/Ol46NR6GCf
         7Tc07S5UkbRVg6cmgWFu4E6ftiJp+wYN4l+6dqE0pQU2ZzfritWU68Cw0Lri4mG2103h
         E+4g==
X-Gm-Message-State: APzg51D0gHf+q9x5eKOOhXUDA6F3jwNU36VgJrXh8rh44MhbHVvC/vXT
        TZ0kGYyJ+BnBlSbBzi1SXRvkBTTEKgysC35ZtxopCA==
X-Google-Smtp-Source: ANB0VdaONdLJx5WHC+sLJa+uCV0XWIgdiXZI01D5VUNWeZhTPXth50citzM36M+RMc2CgrmiylOFIRm4CfgjaD/nk/c=
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr2282117pfc.232.1536232791958;
 Thu, 06 Sep 2018 04:19:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 6 Sep 2018 04:19:31
 -0700 (PDT)
In-Reply-To: <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov> <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov> <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com> <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Sep 2018 13:19:31 +0200
Message-ID: <CACT4Y+a6Y1N1VbpLoJPyK5DFYyr8RGM_=mqpWwina=yTUEtUvg@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 12:59 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 5, 2018 at 7:37 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/5/2018 4:08 AM, Dmitry Vyukov wrote:
>>> Thanks! I've re-enabled selinux on syzbot:
>>> https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
>>> Now we will have instances with apparmor and with selinux.
>>
>> Any chance we could get a Smack instance as well?
>
> Hi Casey,
>
> Sure!
> Provided you want to fix bugs ;)
> I've setup an instance with smack enabled:
> https://github.com/google/syzkaller/commit/0bb7a7eb8e0958c6fbe2d69615b9fae4af88c8ee


But just doing default things does not seem to find much. I guess
common paths through the hooks are well exercised already.
So perhaps if we do more non-trivial things, it can find more stuff.
But what are they? Adding/changing/removing xattr's? Which? What are
the values? Changing security contexts? How? What else?
selinux has own filesystem and we should touch some files there:
https://github.com/google/syzkaller/blob/master/sys/linux/selinux.txt
But we don't anything similar for other modules.
