Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7462220875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7462220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbeGWNnx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:43:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59189 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388306AbeGWNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:43:51 -0400
Received: from rettich.hi.pengutronix.de ([2001:67c:670:100:1d::c3] helo=rettich)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1fhaAi-0006Hw-HC; Mon, 23 Jul 2018 14:42:40 +0200
Received: from jlu by rettich with local (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1fhaAe-0007Gm-Sy; Mon, 23 Jul 2018 14:42:36 +0200
Message-ID: <1532349756.4604.85.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Udit Agarwal <udit.agarwal@nxp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Sahil Malhotra <sahil.malhotra@nxp.com>,
        Ruchika Gupta <ruchika.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Date:   Mon, 23 Jul 2018 14:42:36 +0200
In-Reply-To: <AM5PR0401MB266047028697BCF2851F8F189E500@AM5PR0401MB2660.eurprd04.prod.outlook.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
         <1532076042.3511.203.camel@pengutronix.de>
         <AM5PR0401MB266047028697BCF2851F8F189E500@AM5PR0401MB2660.eurprd04.prod.outlook.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c3
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2018-07-21 at 14:44 +0000, Udit Agarwal wrote:
> Thanks for sharing the documentation changes and feedback.
> 
> Below are the answers to the questions:
> 
> 1. Currently the secure key patch series has been added  to support
> only data blobs.
> It is not supporting key blobs as of now, we have thought of adding
> that support in future.

OK. Do have a plan how the key blobs would be represented in the
keyring? It seems it would need to be some sort of handle instead of
the key data. Would it need a different userspace API?

> 2. Yes secure keys could also be implemented using OPTEE. I will
> change the documentation in next patch version.

Thanks!

Jan
