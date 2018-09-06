Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC0E2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC0E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeIFNNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:13:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:52897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbeIFNNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:13:13 -0400
Received: from homer.simpson.net ([185.221.151.58]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFctN-1g3aQA1nMb-00EheY; Thu, 06
 Sep 2018 10:38:19 +0200
Message-ID: <1536223096.4669.35.camel@gmx.de>
Subject: Re: [PATCH RT 08/22] Revert "x86: UV: raw_spinlock conversion"
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Date:   Thu, 06 Sep 2018 10:38:16 +0200
In-Reply-To: <20180906073549.zu6gdlwor4fwjngs@linutronix.de>
References: <20180905122754.443196118@goodmis.org>
         <20180905122835.654334475@goodmis.org>
         <20180906073549.zu6gdlwor4fwjngs@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tXbTcAi4MbhdKYdBl2VKGN6est0f0zliPM1kZr+AXAhn+0q2KKX
 noknbdNmyU/zC4EYTinv/CubWOR4S6NPOSNGzWK2cNUZgdLzjghBqUlBBzpdXT1Mg4jwJZZ
 jPGttT+tndHdPcQOTQhrPXTqtN8n24eu8Ss4rgEySbnPomI9qhfarg3YQdyhTv6rWEjtbyv
 ksP4F8nX9fzsguF02dOEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nuvb/ooxw/k=:CSJ+bNDXXBiUae4AzCfAYN
 zFY6Si/Sjk+9MyTfHOtGR3cum+eEmhtmUWKiqApJtRTIMsltVcSzE5CtEpxdlTn0vTjYVMO61
 c/sD4ezOPES20r5Mh0fuRHOIC9XwkXom20YfRdc3FOeKuxE+bUGI9ZaWgaIVmzSb0QWW0CdmQ
 dB/yB5Jyzu5nehd4GkoAFPM4rWd0mv0FrFY+VVTTS5rooTmMjSqWc7mKe4at4v2JfaIex9RZw
 IlepZeyw8bTXOmr9vBfdUBXTf+mgTMYbEjJodrjr2jWD3RQ5hBPNbmJqnfe/5lquiZDlEhqgj
 MvMhwPl05PZq/L50mnrVo2TTREH7rTeKPQHJIanKTxDhGIMmbMpX1NL6Wr2Wg/ZF5qz+flBOF
 E6Cd/bf6gh39+JqJ2KSiopWPxziWi2FVLdb3dCER8Bee5Bs7EA/O32EEYTOJE9NBflzBAh7R2
 ewo+oD1AROyRLknzy0JxgBu/iVyAEOn2grsq0YPU8L9H5DIDOUCghWFVmwXr94lWHCj/Kh3Bl
 bG6wN2WZ01ZSFMgsrjsP3+34lFoGFxbj0o6qdqv2WpUSa53/x1IA4GQ1pXMcSkDCm42V8X73o
 iOhURFpbTygDvUAYiorFxtquhdZMhN3F4WijH1Gl4628e3l6o0OEYuzwb7NhMDUUaVy9z/xDI
 7b1GHqsGr6ab/PnFcF88uhBDy0LPnPbsfzECKhu/aSVfPJYKV49RSolrY5PjvxUaxCYUhfnMv
 iMHMLG/8bVw1g9zd9euiP4Jm16MQgHPGw2yrQGx/6VMLq85anLOMNmvWkzI3rb6avchxIvbFW
 FrxSylBLiCcxQFLYHDCkmBakoo5sB+ZnZni8eqFZqlHVcFqVf7b4u1u2XBoLBZXpQXlgmtWhD
 fjavIDmnjuGuuu5ou2Qg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-06 at 09:35 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-09-05 08:28:02 [-0400], Steven Rostedt wrote:
> > 4.14.63-rt41-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > [ Upstream commit 2a9c45d8f89112458364285cbe2b0729561953f1 ]
> > 
> > Drop the Ultraviolet patch. UV looks broken upstream for PREEMPT, too.
> > Mike is the only person I know that has such a thing and he isn't going
> > to fix this upstream (from 1526977462.6491.1.camel@gmx.de):
> 
> I don't think that we need to propagate that revert for stable. I
> reverted it in the devel tree because nobody wanted this upstream and I
> couldn't test it. For that reason I didn't see the point for having it
> in the RT tree.
> However, if you want to revert it for stable, be my guest. It probably
> will have no impact and if it will people might step forward and fix it
> properly / upstream.

I'm in favor of reverting it as useless cruft.  UV has been broken
forever wrt PREEMPT, and nobody cares.  The original interest in UV RT
support evaporated while 2.6.33-rt was still current (and when getting
it working took a bit more than a spinlock conversion). 

	-Mike
