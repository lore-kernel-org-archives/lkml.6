Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A76C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6853214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ceifFKY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6853214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLFQCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:02:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:02:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6FwYew076488;
        Thu, 6 Dec 2018 16:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hcOIepnvEy/olyRd0jHJfwjqlLsqT+6CFo+IXGedwe4=;
 b=ceifFKY4XXltXKxcIau5/srTM1IoPhINh5+GEqkoV7dzgu/og179M2nvFD72q7cAuNdD
 20KEunWvDyqvmD/w+tCxO+dgbZVz8zIJYLyk7GV45XXJit4kMmkfKzd2Dd/PWtU+mwD+
 ZjJwOY1OJLdPNcDqRnah13rLTcVyClRuPcLMivWpp3CkKT2absgfOzRFVn1cGz/ekuFW
 sCnBgMQTg2XXRczuzokxhTEKEp7/B7gf2a1PMsaEd1l2OSwBFWq6qYouKNPu4VDqu8Hp
 ImSsuF87ethFm3KqeRSImojLwRwm0x9iEkqFRhZM5CbPKiA+e+cawa26RLJJ9+unYvVp Cw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p3jxrs0ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 16:01:59 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB6G1wix021844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 16:01:58 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB6G1wkG007462;
        Thu, 6 Dec 2018 16:01:58 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 08:01:57 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id B24C86A00D6; Thu,  6 Dec 2018 11:01:56 -0500 (EST)
Date:   Thu, 6 Dec 2018 11:01:56 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Subject: Re: [PATCH v4 00/14] KVM/X86: Introduce a new guest mapping interface
Message-ID: <20181206160156.GB25299@char.us.oracle.com>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=830
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 10:30:53AM +0100, KarimAllah Ahmed wrote:
> Guest memory can either be directly managed by the kernel (i.e. have a "struct
> page") or they can simply live outside kernel control (i.e. do not have a
> "struct page"). KVM mostly support these two modes, except in a few places
> where the code seems to assume that guest memory must have a "struct page".
> 
> This patchset introduces a new mapping interface to map guest memory into host
> kernel memory which also supports PFN-based memory (i.e. memory without 'struct
> page'). It also converts all offending code to this interface or simply
> read/write directly from guest memory.
> 
> As far as I can see all offending code is now fixed except the APIC-access page
> which I will handle in a seperate series along with dropping
> kvm_vcpu_gfn_to_page and kvm_vcpu_gpa_to_page from the internal KVM API.
> 
> The current implementation of the new API uses memremap to map memory that does
> not have a "struct page". This proves to be very slow for high frequency
> mappings. Since this does not affect the normal use-case where a "struct page"
> is available, the performance of this API will be handled by a seperate patch
> series.

How (if any) does it affect performance?

Thanks!
