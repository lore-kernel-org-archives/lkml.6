Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB04C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F82221019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g6Qi8ztG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfAWSRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:17:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43604 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAWSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:17:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NI4Jap067637;
        Wed, 23 Jan 2019 18:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AJINrUIxo76Q5Ha8suEMASURD6Z2ULXcWJLcTlMdh9g=;
 b=g6Qi8ztGIUAFKQ8FasezS9/gomhncdKMTn8+0kxxKM8lPjxjlea+T637FAc+ofMSTMZI
 MXFflQvJ7IZO8qANx03bLpMYGUJK4p0bO+qoHZSSLdkUlc4ddicf21RugfzNRpxjAkfR
 aXVGMSQw8MJeYNa3/KkrmQMabJSjF+uJB3hREr04kOTUqu7e7jKnwupJiroe+HUiY1Va
 BknZssubyzVybK2DABd+HpSdOaii9EgcaK8h6b/jDcl6plxpTXNKLNe40N1td5u6P2Uh
 BErw05xv8Cf/l23MI/6hYGzHk5LrLssBkbmzSzrIM1EqgIf9U3RHHusVtXmHPOEtf/6O Uw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q3sdekr4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:17:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NIGtBN025480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:16:55 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NIGtKI008364;
        Wed, 23 Jan 2019 18:16:55 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 10:16:55 -0800
Date:   Wed, 23 Jan 2019 13:16:39 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 00/13] KVM/X86: Introduce a new guest mapping interface
Message-ID: <20190123181636.GR19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:00AM +0100, KarimAllah Ahmed wrote:
> Guest memory can either be directly managed by the kernel (i.e. have a "struct
> page") or they can simply live outside kernel control (i.e. do not have a
> "struct page"). KVM mostly support these two modes, except in a few places
> where the code seems to assume that guest memory must have a "struct page".
> 
> This patchset introduces a new mapping interface to map guest memory into host
> kernel memory which also supports PFN-based memory (i.e. memory without 'struct
> page'). It also converts all offending code to this interface or simply
> read/write directly from guest memory. Patch 2 is additionally fixing an
> incorrect page release and marking the page as dirty (i.e. as a side-effect of
> using the helper function to write).
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

Where could one find this patchset?

Also is there an simple test-case (or a writeup) you have for testing
this code? Specifically I am thinking about the use-case of "memory
without the 'struct page'"

And thank you for posting this patchset. It was a pleasure reviewing the
code!
