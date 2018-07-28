Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44626C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F4920862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="keEBZb0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeG1IUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:20:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47091 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeG1IUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:20:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id l16-v6so4932726lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=evjf5q2uRmd00fJph7HB/SmBgrN3yluyRs2f10zwYqg=;
        b=keEBZb0B8b/FRwnA4mCk3luHZ+zhZ2jy8wocNNMv1/akqdRHTALZpzrKjiR7gtHkPM
         6ephmjPyLKbT4E17tIVTY5b+zUMgFS1Q5PBfYuxAQyh//XgKOlLTxJB5LFl4syB8QS2B
         +5hlqb+mAADqWweF2ZUb38X9ETxvrqvve5Po8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=evjf5q2uRmd00fJph7HB/SmBgrN3yluyRs2f10zwYqg=;
        b=ocdUMQTllaFNOu7QfN8sOV/QA4GFsmCBtpgwDUy3N5WYi1gpeIDJyd68O+Hj1mal9w
         OG3TS8pex5RzoglHVZvByEsP6aoS3ZsNBlcrfr8ddVrIFkoPX8WPSoMFS/m5PB9ApMcO
         dflyD0mUOA+iknVmEV9Yhir/+Opq7DG+PbjUxfMPQ3Qx8fPf/G8pIdVb8Hn8WOiDS3Uy
         +UlCB73IEYgReH5wBAEKzgC17+b408LB0zdztX6gnQHk2cUsfOC26QGisQyOMHkEC1H8
         KEk/53MUAJ093Ln6HH1OMPW4h/USrv7R3EpA2cwfywP0f+TUaBZtBmeKGpDzifW5qWr2
         sWMQ==
X-Gm-Message-State: AOUpUlEybverxKVFb46ts+rxAsdVO3vjTfsl3Cmipc5aXqV2xGVAJX/Y
        jv0+6pMXxWxL3ZU8fwWAsXVAc4sCafeb6k2KvYdsNQ==
X-Google-Smtp-Source: AAOMgpduDZvAtMUqO6qRxaB5xzt9++fZ6UEDdT7coyo6FD8zVzgM9eGiilNQx1iVifUNE9/8V/+N49C/Nbiu5UIthO0=
X-Received: by 2002:a19:9646:: with SMTP id y67-v6mr5486965lfd.130.1532760875838;
 Fri, 27 Jul 2018 23:54:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 23:54:34
 -0700 (PDT)
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 28 Jul 2018 12:24:34 +0530
Message-ID: <CA+G9fYtKPNztPdGh78PW1UuPfT9PiN16rv4C4a2jLPvByBzVFw@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/66] 4.17.11-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 July 2018 at 15:14, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.17.11 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jul 29 09:37:38 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.11-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 26cb8e50f1730a1512904d9eb24a86213a1515a2
git describe: v4.17.10-67-g26cb8e50f173
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.10-67-g26cb8e50f173

No regressions (compared to build v4.17.10)


--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
