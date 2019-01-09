Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2869C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7118121726
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DeZW9ov3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfAIGWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:22:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43388 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfAIGWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:22:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so5422612oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 22:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BDh56Ne0m9NwfkO8MGWagziw1fa/CKUsA7ALVy7vV0=;
        b=DeZW9ov3R3uzGLCs0Mb7VfPkzQMjPiyPO4r0e3YyoMz3qMmOJYcXDQMoLRhTvHu5/Z
         mmsxgCdvls5qveq6qDR5g5mlPBg8PMOntGcNWlm3OHPL6EKm4WquNWnDT9ddGYI/TfWk
         Ka/xw6LpxKyfZMXKGvDlDIpknEci7uhlUtfTO5+KoVTT5kIdP8VRXqOKZ8ti1zNNpJE1
         eJo/yUiSFheWzU1GZ3QWfJAwFcdSmsHQ+0p7HyGMvC9fxv9xNCYgjRdhbnENGXRT7L0c
         mlkW0ywjr5iYSwZ+uUpFZ0JuEfao+c1pjTX4dbsnpclGFZtFv7r/i4Z8QxSwt6GK0XME
         le7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BDh56Ne0m9NwfkO8MGWagziw1fa/CKUsA7ALVy7vV0=;
        b=fDaerRtkM7Vew8NmOHeKEHQij7PXupsEh6OelCvqAtyMMi8HLX0zPsNsDlMDCbaDTo
         HXdXCw6xaaa16kZH+NuBrHzxn7yJuHBDaxJl6o8jGobAYBoJSymkyniATbt5XzqqgH1R
         aCb2pFBtA2+3YStiJVKmb7R0XTHJKB46AJoGXuCmwKEEbfhVCoCir4v7DeySiugF9GKj
         mIiydvmYGoyzM7XbVRVV9xkpmQO2ssZNGr9Kx7PiShjqEJzt1noGq4mwVtjFj8jXG51w
         YjgyQc25twLlVZJsqfaqolDZLDkgdzTMmm/Nvm1SbIMUw/7VnXhz3s3L5mpmeoRdpW27
         QE1w==
X-Gm-Message-State: AJcUukeX2eEuqHxJqE2Ulc0l9cif8r9MaJU3SVfHECuI+XZ49xyz5bWx
        y95FJ4ZkekoPSCmWseid1htYyMrtPsyaZ4Dl+ZmZKQ==
X-Google-Smtp-Source: ALg8bN7UCHx8I9KINibiCJo/Zoo97Ru2anEztHk+iLO0vHGkBaxbsG4LhQkqB5Jt/rgcIdc1B0YF+7EBXVNPa3bgVGU=
X-Received: by 2002:aca:4307:: with SMTP id q7mr3249384oia.105.1547014943820;
 Tue, 08 Jan 2019 22:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20190108045853.5471-1-natechancellor@gmail.com> <20190109050036.17322-1-natechancellor@gmail.com>
In-Reply-To: <20190109050036.17322-1-natechancellor@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jan 2019 22:22:12 -0800
Message-ID: <CAPcyv4iBUx66WNpZ5zRvT+Rn+ydPvwB40jbtdpoKLAVFDYh95w@mail.gmail.com>
Subject: Re: [PATCH v2] nfit: Mark some functions as __maybe_unused
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 9:03 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On arm64 little endian allyesconfig:
>
> drivers/acpi/nfit/intel.c:149:12: warning: unused function 'intel_security_unlock' [-Wunused-function]
> static int intel_security_unlock(struct nvdimm *nvdimm,
>            ^
> drivers/acpi/nfit/intel.c:230:12: warning: unused function 'intel_security_erase' [-Wunused-function]
> static int intel_security_erase(struct nvdimm *nvdimm,
>            ^
> drivers/acpi/nfit/intel.c:279:12: warning: unused function 'intel_security_query_overwrite' [-Wunused-function]
> static int intel_security_query_overwrite(struct nvdimm *nvdimm)
>            ^
> drivers/acpi/nfit/intel.c:316:12: warning: unused function 'intel_security_overwrite' [-Wunused-function]
> static int intel_security_overwrite(struct nvdimm *nvdimm,
>            ^
> 4 warnings generated.
>
> Mark these functions as __maybe_unused because they are only used when
> CONFIG_X86 is set.
>
> Fixes: 4c6926a23b76 ("acpi/nfit, libnvdimm: Add unlock of nvdimm support for Intel DIMMs")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Looks good, applied.
