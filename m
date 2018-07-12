Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A973C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1BA2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qyl4MrQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1BA2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbeGLCXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:23:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbeGLCXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:23:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C2EdEh068823;
        Thu, 12 Jul 2018 02:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=/vMmNmc3QsEAJm2bqyxeLzJm0+PayvxlShjOGcRfvlQ=;
 b=Qyl4MrQnOIxig62yt7CZ3XAdtiLzRqqoFA8vz+FnrF4c02lIKQoBYrxvmQz2J4Zz4adY
 U1t7FoEiHkVZMNdmkxztheb1DQMYAqcb9oANNKjeG7CiOMlx4d+tjTJLBMluPkdrxc+i
 sBUQVoMort9CxNuje9uZKrLOu5o/Thr8X9UjcPQOVdImNYNRkl1FsLakyUtf8Z3Qq1Md
 8jGhbQT8po6jetMPsBQ5enaPZ1V1wWfOYfGAMK22Fo+4HhOO/ZIgRDgGuRjOqPvCS+Au
 5GeyGnLcc1j0NTQbMrou9hJmt/+mgPZ4hhwlXpttnNhvPKCNFr1ItoMLWsDMNPPFoF/B lg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2k2p7e0fqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:16:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6C2G6fe002283
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:16:06 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6C2G5Si016467;
        Thu, 12 Jul 2018 02:16:06 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 19:16:05 -0700
Received: by mail-oi0-f44.google.com with SMTP id w126-v6so52959300oie.7;
        Wed, 11 Jul 2018 19:16:05 -0700 (PDT)
X-Gm-Message-State: AOUpUlFMpWlKSxCmv/+zaoSKXQIJEPdE9uUXuWImM5Se7TeCVrvulz8u
        1Hb2pGTXohEtwTqFqDkzOKIqCu/w4HGTqdnmY4c=
X-Google-Smtp-Source: AAOMgpdmILHvJotw7XrzLE+uWcQmGlnnYaqM+SurMiZ27NTcSIv9DEalFOmzu1zE+47TBF3qzyktfSed3NfkPjysLZ0=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr342877oia.229.1531361765115;
 Wed, 11 Jul 2018 19:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180706161307.733337643@linutronix.de> <20180706162049.387233770@linutronix.de>
In-Reply-To: <20180706162049.387233770@linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 11 Jul 2018 22:15:29 -0400
X-Gmail-Original-Message-ID: <CAGM2reZupVs-smToe5oy=q-7pYgAyr3GKNn4NcXTFMe0CWtfkw@mail.gmail.com>
Message-ID: <CAGM2reZupVs-smToe5oy=q-7pYgAyr3GKNn4NcXTFMe0CWtfkw@mail.gmail.com>
Subject: Re: [patch 2/7] x86/kvmclock: Remove page size requirement from wall_clock
To:     tglx@linutronix.de
Cc:     LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, jgross@suse.com,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=771
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There is no requirement for wall_clock data to be page aligned or page
> sized.
>

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
