Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9700C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F2E205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F2E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeJWBbn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:31:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:49714 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJWBbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:31:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 10:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,412,1534834800"; 
   d="scan'208";a="83227968"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga007.jf.intel.com with ESMTP; 22 Oct 2018 10:12:22 -0700
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 22 Oct 2018 10:12:21 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.118]) with mapi id 14.03.0319.002;
 Mon, 22 Oct 2018 20:12:07 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 00/21] tpm: separate tpm 1.x and tpm 2.x commands
Thread-Topic: [PATCH v7 00/21] tpm: separate tpm 1.x and tpm 2.x commands
Thread-Index: AQHUaBMHlZfugjzXrESpNofEmU+hxKUrgomg
Date:   Mon, 22 Oct 2018 17:12:06 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9FA974@hasmsx109.ger.corp.intel.com>
References: <20181019182307.17745-1-tomas.winkler@intel.com>
 <alpine.DEB.2.21.1810200419110.9963@jsakkine-mobl1>
In-Reply-To: <alpine.DEB.2.21.1810200419110.9963@jsakkine-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjM0YTkzYjYtNWNhNy00MGUyLWIzZjYtNDAyMWM3ZWI0NzE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiT3dra2lsZlpNd0hHeUhPT1BFcXhmTFpkb0w3eXc1RVdwZFhcL3dkZHdCVml1WHJNZTZUUG53Nm5IMGRqM1V5a08ifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.252.27.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, 19 Oct 2018, Tomas Winkler wrote:
> > This patch series provides initial separation of tpm 1.x and tpm 2.x
> > commands, in foresight that the tpm 1.x chips will eventually phase
> > out and can be compiled out for modern systems.
> > A new file is added tpm1-cmd.c that contains tpm 1.x specific commands.
> > In addition, tpm 1.x commands are now implemented using tpm_buf
> > structure and instead of tpm_cmd_t construct. The latter is now removed.
> >
> > Note: my tpm 1.x HW availability is limited hence some more testing is
> needed.
> >
> > This series also contains two trivial cleanups and addition of new
> > commands by TCG spec 1.36, now supported on new Intet's platforms.
> >
> > V6: 1. Dropping tpm: move pcr extend code to tpm2-cmd.c and rebasing
> code over that change
> >    2. Trivial fixes in kdoc and header
> > V7: 1. Add backportable patch for nuvoton duration calculation
> >    2. Rebase durations patches over it.
> >    3. Fix notorious typo tmp->tpm
> >
> >
> > Tomas Winkler (21):
> >  tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x
> >  tpm2: add new tpm2 commands according to TCG 1.36
> >  tpm: sort objects in the Makefile
> >  tpm: factor out tpm 1.x duration calculation to tpm1-cmd.c
> >  tpm: add tpm_calc_ordinal_duration() wrapper
> >  tpm: factor out tpm_get_timeouts()
> >  tpm: move tpm1_pcr_extend to tpm1-cmd.c
> >  tpm: move tpm_getcap to tpm1-cmd.c
> >  tpm: factor out tpm1_get_random into tpm1-cmd.c
> >  tpm: move tpm 1.x selftest code from tpm-interface.c tpm1-cmd.c
> >  tpm: factor out tpm 1.x pm suspend flow into tpm1-cmd.c
> >  tpm: factor out tpm_startup function
> >  tpm: add tpm_auto_startup() into tpm-interface.c
> >  tpm: tpm-interface.c drop unused macros
> >  tpm: tpm-space.c remove unneeded semicolon
> >  tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure
> >  tpm1: implement tpm1_pcr_read_dev() using tpm_buf structure
> >  tpm1: rename tpm1_pcr_read_dev to tpm1_pcr_read()
> >  tpm1: reimplement SAVESTATE using tpm_buf
> >  tpm1: reimplement tpm1_continue_selftest() using tpm_buf
> >  tpm: use u32 instead of int for PCR index
> >
> > drivers/char/tpm/Makefile            |  16 +-
> > drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
> > drivers/char/tpm/tpm-chip.c          |  11 +-
> > drivers/char/tpm/tpm-interface.c     | 817 +++--------------------------------
> > drivers/char/tpm/tpm-sysfs.c         |  52 +--
> > drivers/char/tpm/tpm.h               |  97 ++---
> > drivers/char/tpm/tpm1-cmd.c          | 781
> +++++++++++++++++++++++++++++++++
> > drivers/char/tpm/tpm2-cmd.c          | 301 +++++++------
> > drivers/char/tpm/tpm2-space.c        |   2 +-
> > drivers/char/tpm/tpm_i2c_nuvoton.c   |  11 +-
> > drivers/char/tpm/tpm_tis_core.c      |  10 +-
> > include/linux/tpm.h                  |  11 +-
> > security/integrity/ima/ima_crypto.c  |   5 +-
> > 13 files changed, 1082 insertions(+), 1034 deletions(-) create mode
> > 100644 drivers/char/tpm/tpm1-cmd.c
> >
> > --
> > 2.14.4
> >
> >
> 
> Starts to look reosonable:
> 
> https://patchwork.kernel.org/project/linux-integrity/list/?series=33257
> 
> This is the list of patches (assuming that I didn't miss anything) that still
> need tested-by tags:

Those are just code movements, we are running them form months on our systems.

> 
> - tpm: factor out tpm1_get_random into tpm1-cmd.c
> - tpm: factor out tpm 1.x pm suspend flow into tpm1-cmd.c
> - tpm1: rename tpm1_pcr_read_dev to tpm1_pcr_read()
>    (the subsystem tag is wrong in this, just noticed, should be 'tpm:')
When have you established this requirement I missed that and it cannot be deduced from the git history.

> - tpm: use u32 instead of int for PCR index

The last one maybe need some more target testing.

Thanks
Tomas

