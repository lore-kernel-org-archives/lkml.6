Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A62C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6452089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6452089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJGAD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:03:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbeJGAD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:03:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w96Gwjj5081787
        for <linux-kernel@vger.kernel.org>; Sat, 6 Oct 2018 12:59:52 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mxs255y07-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 12:59:52 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 6 Oct 2018 12:59:51 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 6 Oct 2018 12:59:48 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w96GxlmL27066444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 6 Oct 2018 16:59:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85204B205F;
        Sat,  6 Oct 2018 12:57:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63EEEB2065;
        Sat,  6 Oct 2018 12:57:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.150.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  6 Oct 2018 12:57:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C05A216C366B; Sat,  6 Oct 2018 09:59:47 -0700 (PDT)
Date:   Sat, 6 Oct 2018 09:59:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     David Miller <davem@davemloft.net>
Cc:     ldr709@gmail.com, linux-kernel@vger.kernel.org, 3chas3@gmail.com,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH] atm: nicstar: Replace spin_is_locked() with
 spin_trylock()
Reply-To: paulmck@linux.ibm.com
References: <20181004074657.17597-1-ldr709@gmail.com>
 <20181005.143236.511366748709139149.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005.143236.511366748709139149.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100616-0064-0000-0000-0000035B2974
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009831; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098789; UDB=6.00568359; IPR=6.00878830;
 MB=3.00023641; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-06 16:59:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100616-0065-0000-0000-00003AE3E9E4
Message-Id: <20181006165947.GQ2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=686 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810060172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 02:32:36PM -0700, David Miller wrote:
> From: Lance Roy <ldr709@gmail.com>
> Date: Thu,  4 Oct 2018 00:46:57 -0700
> 
> > ns_poll() used spin_is_locked() + spin_lock() to get achieve the same
> > thing as a spin_trylock(), so simplify it by using that instead. This is
> > also a step towards possibly removing spin_is_locked().
> > 
> > Signed-off-by: Lance Roy <ldr709@gmail.com>
> 
> Applied to net-next.

Thank you, Dave!  I have dropped this one from my tree.

							Thanx, Paul

