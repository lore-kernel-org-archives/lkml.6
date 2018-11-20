Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82DAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD1F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icb0SA43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD1F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeKTLRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:17:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50316 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbeKTLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:17:50 -0500
Received: by mail-it1-f195.google.com with SMTP id a185so989482itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1gbcvGTtYg8n+MyOZPRpYYtklSSxt1MiCR3YwDop6Y=;
        b=Icb0SA43tNiPnZFbg2JxG/76N3BOtsqrKiq0QMplYlIR1j18tZLM3Ep11U6fORz12G
         6+ZbsUl7y+Yb3YArt5LkeRd4Vfe+R7oQdkAx8ab7d6g0kL1mgZKpUdLUpLdqVFqrmcim
         Dddr2JkGF2Y7Dch+AmeWbj8gFQf/lW3mHM5Tj8h8jnq2MfiOJjzzvUPpHNFWZXDpibZi
         nE9rRyBkDDHP2C5Oc4GnopAvS5Hzu8DLwH7FAiZ0WhVIkrNiXyKelvk+ZmOt47n32iD4
         1VQk3MzbBGzQsvvZ8g+QmpssGE//J075hwI5i4zy0rRxSXAxmRZSNjni+Zn3llq1AqEC
         tzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1gbcvGTtYg8n+MyOZPRpYYtklSSxt1MiCR3YwDop6Y=;
        b=OH7xmfe0JILMERpVjb8Hcn3eZmGJyUzGDpCAenWoCYGmENUOot5/hksaOZqqSW+/Zk
         Vk/ZzrtqSPYj4JhnuIHUjrA/bh0LZfE6l+u3O8HKvkBCtrAMDQUcGcnS+a1ojSoAeH/P
         dv4fz8Uo20IDtLHHxBStKUn1fUDNHRVsxVwdAQQ5Zd3N8bQYO6gInWjgmkuMigDpXeYF
         w7FyEZNMZfn29rEbWMbIKhMY0/mCUnsjVHHOEmlAwgMmbz9cc/yvC7FCp6Sg2giqf3rA
         OHEgX1ZuCFxjFS5cEpV+V7NKZRKuCKEp3IyE90LrmmHGx0HTy9jnCSRMU9r8V1r263xW
         IBuw==
X-Gm-Message-State: AA+aEWZVgFtoITzcX8o/Uzbqh3ppUmYkdHNrvn+vffBJWpmeLokaVFSV
        phFeHZpNZLUrhvyTvVnBq+yECAKKa0wsoN04FbQ=
X-Google-Smtp-Source: AJdET5eTA+6nLEgu16bOpvRGjCYNAimuPfTySdIvujyBMx/VxDjeSkeamJEJRg6ABTDJKvnooyN4L/eyWTGG0OEnF/M=
X-Received: by 2002:a05:660c:681:: with SMTP id n1mr345511itk.37.1542675086791;
 Mon, 19 Nov 2018 16:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20181119154334.18265-1-tiny.windzz@gmail.com> <c9c572ed-05a1-cec9-97e9-2b66cb58afcc@intel.com>
 <CAEExFWun3LL8++PMvFzfuufXTK79BgS8-KS+gs=sR-icLnJDag@mail.gmail.com>
In-Reply-To: <CAEExFWun3LL8++PMvFzfuufXTK79BgS8-KS+gs=sR-icLnJDag@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 20 Nov 2018 08:50:39 +0800
Message-ID: <CAEExFWuEO_52BZCBX1jV5f8s+Ud5fjo5vodwKM11iUZEd7aR5Q@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/dump_pagetables: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
To:     dave.hansen@intel.com
Cc:     Kees Cook <keescook@chromium.org>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees:

I want to listen to you.

--Yangtao
On Tue, Nov 20, 2018 at 8:49 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> Hi Dava:
>
> How about just change the ptdump_fops and ptdump_open?
>
> Yours,
>     Yangtao
> On Tue, Nov 20, 2018 at 1:06 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 11/19/18 7:43 AM, Yangtao Li wrote:
> > > -static const struct file_operations ptdump_curusr_fops = {
> > > -     .owner          = THIS_MODULE,
> > > -     .open           = ptdump_open_curusr,
> > > -     .read           = seq_read,
> > > -     .llseek         = seq_lseek,
> > > -     .release        = single_release,
> > > -};
> > > +DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
> >
> > FWIW, I rather dislike this conversion and the DEFINE_SHOW_ATTRIBUTE()
> > approach in general.  It makes it basically impossible to go from
> > ptdump_curusr to ptdump_open_curusr without opening up the macro and
> > reverse-engineering it.
> >
> > My test is that for these macros to be sane, I need to be able to find
> > "ptdump_open_curusr" by grepping for "ptdump_curusr".  This fails the test.
> >
> > I don't think saving a few lines of code is worth the obfuscation.
