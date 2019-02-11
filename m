Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7513C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2A9214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cupuk+a+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfBKVRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:17:22 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40084 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKVRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:17:21 -0500
Received: by mail-wm1-f50.google.com with SMTP id q21so707885wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V1nWj6dTvQBLqLy2OMcT5c06edDRc3MnyEzI3K4DcIE=;
        b=Cupuk+a+4ZaqABXLSXclBfzY40jgWQMBzDzTtvKZ861zi9y01nM9Hzb+NaKZ1nWEde
         vO+Oq8/d2JdH2MX94MnhzyDIKsvkwVDIR1IQ0SG8a9dDyS7igVA8eAmI17byBa/bD8z2
         hPAcA3aodVx4aGFycozEaxJa2Yog5JLFN4Jqc0hJrzw9bofN+m05400vuoNzmMyYS1/F
         By3WkLBqHi2UiVTywMrwerdNXoekKlqyyCoJLRCjF1HIdE6VvOyuDfJjVG1cJf+giCrg
         PSb3JzFOVC8sEv706CfyW28S1rI0RWsNLOw51vZAkxF26W4ccWrWXvC8KKeqwVFCcRnD
         r6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V1nWj6dTvQBLqLy2OMcT5c06edDRc3MnyEzI3K4DcIE=;
        b=iYDgWhTD6x7J165aSdCAJePhAyaVoFVexu6YuASKJNOiR7Iw8rLMgBkWBIOCT/StSo
         NH4h1NisJt0L+W4PpVp/Z6rLZoffipJyqtSNZvoEfT7ve/VvoEZQ3A0KD0V775N2iLGo
         3rRGrydtZQ27FnlC5+8KcCQgrygdvKdiqUTDaaUKbwmGA+TvVsfAgi7jGITaG/WRTebY
         X0gu/BHo7AoAKuIkhjeHv319DwtQFdUut/NUXwWII/oAr5QyVtogtNhkKCH8IrqnGkLt
         qSuqYwfsa49fz+ToABLFlatq1wwCWZTBtOST08Gjxwu3gIv0PPLmjPk543EyCUYZGTyo
         Z9Rw==
X-Gm-Message-State: AHQUAubpHCTm6c6FwUgtoZ0WHxYDMHy7gUmSCu1SvzIW01YQiKRmBbsq
        3lZ+T4x/RljwHYL7aEDi0A==
X-Google-Smtp-Source: AHgI3IbJ9UGt6VRGuco/FxR0EmeBZ1zkhqQYQmWwDNy4lpUToG3bBi+jB5NZ6hqykX+BEmGfs4nfJg==
X-Received: by 2002:a05:600c:2113:: with SMTP id u19mr199136wml.14.1549919839501;
        Mon, 11 Feb 2019 13:17:19 -0800 (PST)
Received: from avx2 ([46.53.242.247])
        by smtp.gmail.com with ESMTPSA id t12sm837629wmi.11.2019.02.11.13.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:17:18 -0800 (PST)
Date:   Tue, 12 Feb 2019 00:17:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        mcgrof@kernel.org, longman@redhat.com, linux@dominikbrodowski.net,
        keescook@chromium.org, joe.lawrence@redhat.com,
        ebiederm@xmission.com, christian@brauner.io
Subject: Re: + sysctl-return-einval-if-val-violates-minmax.patch added to -mm
 tree
Message-ID: <20190211211716.GA31039@avx2>
References: <20190211210632.Nfd0f%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211210632.Nfd0f%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:06:32PM -0800, akpm@linux-foundation.org wrote:

> @@ -2848,8 +2848,10 @@ static int __do_proc_doulongvec_minmax(v

> -			if ((min && val < *min) || (max && val > *max))
> -				continue;
> +			if ((min && val < *min) || (max && val > *max)) {
> +				err = -EINVAL;

I was asked to return ERANGE in kstrto*().
If nothing, it gives better error message:

	$ ./a.out
	foo: Numerical result out of range
