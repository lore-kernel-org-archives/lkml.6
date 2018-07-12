Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7827C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6886020BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UTaoaMzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6886020BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbeGLCjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:39:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34296 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389977AbeGLCjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:39:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C2USNs078948;
        Thu, 12 Jul 2018 02:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=mixMqdTPtuZjEjn2edCAG+OVASPU1lDiEcAX5gE13J8=;
 b=UTaoaMzbTBullOzCvFN3mvW2ljq34txqisOW7TyqKC2FQiAfk1Mr5+czPuZFwyDiIgCh
 0VtON44YxPC9ENlpxauBJwrsOD/nGOfREEbCbRLKIghb89QWniJHlYf+3ssFjzVWwh77
 WTrIrXo4TKCn0af5A/6EPMPHnW7KuQQA5a92zoU5Tda49O/164tO5dqLaPYZ4Igo61/D
 RxT01HCOxUZX/rMVfJD9A9G2+90QEwWT3lp4iFgcE7HChTV8zKV9v2st7FMvXeSH5o8a
 zM7ROXXRRObtEtA8lAr+rfC9mA9G7RtufK2UEsX6kENf2265HDh36QTmEmVA7mInZilo Ug== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k2p7e0gfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:32:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C2WUMJ000928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:32:30 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6C2WUbm012191;
        Thu, 12 Jul 2018 02:32:30 GMT
Received: from mail-oi0-f46.google.com (/209.85.218.46)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 19:32:29 -0700
Received: by mail-oi0-f46.google.com with SMTP id i12-v6so53044533oik.2;
        Wed, 11 Jul 2018 19:32:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlFRlFwrnZXu7UbYi1a7msqR/WIkggOb4TTdD7dfQbqlVCMVBwNp
        wIAX/LY05aFeQqUwHASJMcKosG4nOHXf4/AKk7Y=
X-Google-Smtp-Source: AAOMgpda/NqehOPRXonpmZ9rQc0LcnP1rgLXju84qfG5iAHrzm4nX7VjSDbI0nvBmfPFKfSGDBPE2eATHO+tvqXLRbQ=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr440281oia.156.1531362749280;
 Wed, 11 Jul 2018 19:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180706161307.733337643@linutronix.de> <20180706162049.683940655@linutronix.de>
In-Reply-To: <20180706162049.683940655@linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 11 Jul 2018 22:31:53 -0400
X-Gmail-Original-Message-ID: <CAGM2rebntngKqLacZfVqCRuabMXY9ZQP=6UvkNj9aWqaEMqRfA@mail.gmail.com>
Message-ID: <CAGM2rebntngKqLacZfVqCRuabMXY9ZQP=6UvkNj9aWqaEMqRfA@mail.gmail.com>
Subject: Re: [patch 5/7] x86/kvmclock: Mark variables __initdata and __ro_after_init
To:     tglx@linutronix.de
Cc:     LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, jgross@suse.com,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=693
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The kvmclock parameter is init data and the other variables are not
> modified after init.

LGTM:
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
