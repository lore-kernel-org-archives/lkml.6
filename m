Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E1FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1F323F98
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNYery4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1F323F98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeFVJd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:33:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40104 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeFVJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:33:26 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so8136757lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEw2oLBGBbiTpzOJOMiw124rTqt8rC/MjJ66drVrrAw=;
        b=ZNYery4VrFeAo5lLhJDO0TvFYL354tCPnkEYX27PxGONkrtiaAtxa4HwRKb9ZqB1MI
         Lm2EWg+sTxDy3dppEzMMtx1ariB7SKpHeihLNucK6mPSH0YTvmTqFYZW7qobvUqK2qr7
         bI+HZNdYysdZL2fR383PBg2VD5OlvNmWSGWqYQthIVJEg+aQ3uvyK6VBlJPYACEWtc3s
         k1Sd5OwqNdLbxsKK8fP4v4Xd5INSF8ta6ceX4Ut0hgoz8yzXeVToKea7LzIv4LX5WSoU
         IwNQ8LAh89Z7X78j5aALHEbdZZqBCEoAL0zNJljD2qkHrsIgOz/UW1pe20bwoNN6ecjK
         9mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEw2oLBGBbiTpzOJOMiw124rTqt8rC/MjJ66drVrrAw=;
        b=qnjlXvx/f4BsiYCMt6Ju4xTsPaGwRskqYXtn8DgHQc6m0LFYuAzv5KkjNBkzg3PhSu
         DwsX7GdKuYVA3OOft6LAuW7oiCeUB7X9+HADZ/TPS5niGTOg01Cmlo+w3xM9s6JGtmkw
         1+4uOG6RgSu3p0eQXs/tbDa+lnOECENCr23dfWTUBAB/QNSx+NxxUdEZM7YuaAmR7H1E
         PwI4paunCHwZRXymPFQYJj64OPXM+F8Lv+yUAceXdOx/+j3ALSmgIe+IAEcJvJda7yeO
         h/ykrjtCLW2uD90qOTyTrYF9o8v87KDwEAWJ+HmeAeLyky5tDR6SWOwelVS0Pu0l9zFV
         ovnA==
X-Gm-Message-State: APt69E3GWGCa99vpI3tt0Ep7QZFLJfWsoq8AcKnO6MgtXpniH6rH51Jh
        akwoRrotr7IgmIJGTvHitg9h9K7UNPDFWCKIpss=
X-Google-Smtp-Source: ADUXVKL22O1Gyvb+/SDGBgMwCmbZvkneL5OkXQr/NrzJtsA3ncCBkBJsk9jHVWZMFl6iSdErk1v0nB0JRP4Xt0LUR/Q=
X-Received: by 2002:a2e:12dc:: with SMTP id 89-v6mr701763ljs.63.1529660005213;
 Fri, 22 Jun 2018 02:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <1529056341-16182-1-git-send-email-ufo19890607@gmail.com> <20180622083949.GR10465@dhcp22.suse.cz>
In-Reply-To: <20180622083949.GR10465@dhcp22.suse.cz>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Fri, 22 Jun 2018 17:33:12 +0800
Message-ID: <CAHCio2jkE2FGc2g48jm+ddvEbN3hEOoohBM+-871v32N2i2gew@mail.gmail.com>
Subject: Re: [PATCH v9] Refactor part of the oom report in dump_header
To:     mhocko@kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 6adac113e96d..5bed78d4bfb8 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -15,6 +15,20 @@ struct notifier_block;
>  struct mem_cgroup;
>  struct task_struct;
>
> +enum oom_constraint {
> +     CONSTRAINT_NONE,
> +     CONSTRAINT_CPUSET,
> +     CONSTRAINT_MEMORY_POLICY,
> +     CONSTRAINT_MEMCG,
> +};
> +
> +static const char * const oom_constraint_text[] = {
> +     [CONSTRAINT_NONE] = "CONSTRAINT_NONE",
> +     [CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
> +     [CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
> +     [CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
> +};

> I've suggested that this should be a separate patch.
I've separate this part in patch v7.

[PATCH v7 1/2] Add an array of const char and enum oom_constraint in
memcontrol.h
On Sat 02-06-18 19:58:51, ufo19890607@gmail.com wrote:
>> From: yuzhoujian <yuzhoujian@didichuxing.com>
>>
>> This patch will make some preparation for the follow-up patch: Refactor
>> part of the oom report in dump_header. It puts enum oom_constraint in
>> memcontrol.h and adds an array of const char for each constraint.

> I do not get why you separate this specific part out.
> oom_constraint_text is not used in the patch. It is almost always
> preferable to have a user of newly added functionality.

So do I need to separate this part ?

Thanks
