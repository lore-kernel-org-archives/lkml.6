Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71473C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CF821569
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Thj1IXqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CF821569
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeHBV0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:26:21 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40024 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeHBV0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:26:20 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so5610877oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lREbU5nO+yKjW8KwBiFYjYeD9wWhVpX/dcmCv11tXJQ=;
        b=Thj1IXqVBwpD85aJQOtn8fwm1gFlxjylqPZ9mD2D3jBwcTzMSDWjHWy6M6sqUxD+Xl
         lY2MYc9ZOAF0Wlv0IMcfn7A7FPYKovLRn7TtJJD0kSI1TVfYexAv84LjVlXFag5wMZsm
         WtOsCjaqBD6KAeg4uvYVLFlUft/EsBO9EYfz08D+ckaBlXqJbqQaTsTX/RvVbbUyG8Cx
         cDbh5IoPU8Q0/xV/eBL3hJDcYfcZrgr+FlvaxIbR5VmjqJiTkbYCk4jn3h1/N4sd8N3b
         kwGLsMPVzIPfL6EhbBvtEzPtZBUOAFy11Ev2xUbVAaqqWsDhwCIDDaCsiqjgbyZI7EH3
         UHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lREbU5nO+yKjW8KwBiFYjYeD9wWhVpX/dcmCv11tXJQ=;
        b=YVR7zjWx1vkLdrlW9HTkBcwImTCvyuzZgyOOSey92pgEY2vhv4n92F8sWchvskLrYx
         8hnmh1d6o8/wkpbWOxDOgOGqLESAgarfK4FNYrwgunp+/wrZq7nCdocDYkZdU4p7t2A4
         y+50FKeb9hGBThSMcPfa79jIcz0Qpgfh7MmdwnhsuZyD2QTXYfajlLGMq8ohU/xIimJc
         Au97/gXWA1cczxhL5/HWw5vBNAf8sNcOVRyDlUk38fqEFyX/5bf4zk/dfq1Sc47G42bo
         Noc49HbVSDBPRTOsGsb8a665NU+9MlP8aoqlDwgdH3N9ZS5GXYtC2kb/Hv+gSX69AGgT
         m0pw==
X-Gm-Message-State: AOUpUlE/cI9e5cEamn+JA9KKZS/FmRfgLotD+SKXEzzRxc5H+L3V1CnQ
        396JPzc/DgiujdPFf++YVQZUmyKyGZu1yIKHmNWVUA==
X-Google-Smtp-Source: AAOMgpfNfJd0KTil1Kd1J7PH7umdKfD8TK8OdDtCZcpebRLmT1SaMmPBdJmT7709x3FkuePr5i0bixky0bVgtiihTUI=
X-Received: by 2002:aca:ab11:: with SMTP id u17-v6mr112484oie.53.1533238428084;
 Thu, 02 Aug 2018 12:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180730211254.173686-1-pshier@google.com> <alpine.DEB.2.21.1807302342570.1725@nanos.tec.linutronix.de>
 <CACwOFJQqqh6m2x+JXBnmeCzS7Zb-3e+5iPzp_vAZPGCqW+i_8w@mail.gmail.com> <alpine.DEB.2.21.1808011954410.1835@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808011954410.1835@nanos.tec.linutronix.de>
From:   Peter Shier <pshier@google.com>
Date:   Thu, 2 Aug 2018 12:33:37 -0700
Message-ID: <CACwOFJSta=jM7LDiEtT-V_UnCwhggurDa4B+dViqLcdyPvYGxQ@mail.gmail.com>
Subject: Re: [PATCH] proc: added ept_ad flag to /proc/cpuinfo
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Thomas. I missed what I think is your fundamental point
regarding duplication created by this patch between CPU feature bits
and KVM's consumption of the IA32_VMX_EPT_VPID_CAP MSR.

Should all the features in this MSR be exposed via CPU feature bits
and should KVM consume only from there rather than reading the MSR
directly? There are 16 feature bits in the MSR per SDM Vol 3d section
A.10.
