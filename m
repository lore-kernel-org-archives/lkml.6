Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3FBC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5772081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="e3Bw94/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5772081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeKHFGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:06:20 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40067 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeKHFGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:06:20 -0500
Received: by mail-ot1-f44.google.com with SMTP id s5so1924147oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNRFqy2e53r3+iZ5AdP9DFE+PFMWD5guz89RGBZhZBA=;
        b=e3Bw94/eqs/7TyWmAxEfOChsYWwOvUNcbYGY7rWLm+6Mw8Un4fSnl/FgZnyZd8WkT/
         FSah9yxXjjeIjHWwZKsxPLCVrp4LOMVUrJl25hRahV/aFad6RDsWt2FY/ctOlmMmwydu
         m49skXtpTE2Fk1MLhW6UcbUTnzICcqEEall6QwO69IZSsglmUZJs78PIabLkjqpvMjj+
         aUmCTMR52s3pXCzf/mGtkpuYkuLwnqLOl3GvXhhpsPMFGh/j5khS1vUrPXleHEV8aEnc
         XIqDQ9ZuRnHj7Q0DfGt51Vz67Bj1vJBy61F9JAz9S8S2mIkfCS5/c27rbHKjAa7im1oJ
         ndJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNRFqy2e53r3+iZ5AdP9DFE+PFMWD5guz89RGBZhZBA=;
        b=t1uCj0e3ha5s9JH3K+144rgtYyNJ38cW7X4tR1Boo9cU5+hkyb6AySY9iU73911iFj
         1TQuvmc7QUQuUqC2cxNhQrcysgIqvUPVxFW/TGOt3ytC6Rt4hIhbC0ePQfauiqy6c1dT
         3JsNCtiQzWt6jm9aHjhPH6+VLXqRpTqDs7OWJRi8CTL8UjZZW2tUGWLuWr2gAbDhXmYy
         fqjUI0jlW4yXsOuTcK7Sp57Ls450ZDp3hyvYAzaEBPLIRNbN66cW4SEeKCMe5tSCMFc+
         g7VQtQ4Y/01mRiBE0xLm3ZmaUpTcAIUkTlR4zCG4n6O9+PJ5itliZSWdH5XzOTEKTYVZ
         JFnA==
X-Gm-Message-State: AGRZ1gJWCU8gmLm4f9J9YTakMFn3lIfsbJmVkiiqIF3zPpb1DNlKcMsZ
        T8pKlbmG9Tshc7QHwjF1ZRoBStWOMpXEFDUjfKrPlA==
X-Google-Smtp-Source: AJdET5dvEEyDC9TGhztqDyVtjYNtiI2T1J+dHHGnBJvPfVO+x47FRGqi9E8ZKvn0nWBP08BK7gEAOVOdkiR/GIoHerc=
X-Received: by 2002:a9d:f07:: with SMTP id 7mr939783ott.353.1541619273769;
 Wed, 07 Nov 2018 11:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20181107185241.26982-1-toshi.kani@hpe.com>
In-Reply-To: <20181107185241.26982-1-toshi.kani@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 7 Nov 2018 11:34:22 -0800
Message-ID: <CAPcyv4hE49JiFdaM_L0+KPQayZ0qRYokNRPxD5YuwCCp4fzkqQ@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Fix __nd_ioctl() to check error in cmd_rc
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 10:52 AM Toshi Kani <toshi.kani@hpe.com> wrote:
>
> ndctl zero-labels completes with a large number of zeroed nmems when
> it fails to do zeroing on a protected NVDIMM.
>
>   # ndctl zero-labels nmem1
>   zeroed 65504 nmems
>
> When an ACPI call completes with error, xlat_status() called from
> acpi_nfit_ctl() sets error to *cmd_rc.  __nd_ioctl(), however, does
> not check this error and returns with success.
>
> Fix __nd_ioctl() to check this error in cmd_rc.

So this arrangement is by design and the bug is in the ndctl utility.

A successful return code from the ioctl means that the command was
successfully submitted to firmware. It's then up to userspace to parse
if there was a command specific error returned in the response
payload. Automatically returning cmd_rc removes the ability for
userspace tooling to do its own command specific error handling. With
this change userspace could no longer be sure if the failure is in the
submission or the execution of the command, or determine if the
command response payload is valid.
