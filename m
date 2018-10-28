Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9DBC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220562082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220562082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeJ2CHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:07:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbeJ2CHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:07:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9SHE6Ue014087
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:21:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nd53ajs97-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:21:46 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 28 Oct 2018 13:21:45 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 28 Oct 2018 13:21:42 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9SHLfgx42074236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 28 Oct 2018 17:21:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 676B3B2066;
        Sun, 28 Oct 2018 17:21:41 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 452B8B2064;
        Sun, 28 Oct 2018 17:21:41 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.185.180])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 28 Oct 2018 17:21:41 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B097316C266E; Sun, 28 Oct 2018 10:21:42 -0700 (PDT)
Date:   Sun, 28 Oct 2018 10:21:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] rcu: doc: update example about stale data
Reply-To: paulmck@linux.ibm.com
References: <20181028021653.155513-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028021653.155513-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102817-2213-0000-0000-0000030BCBF9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009945; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01109271; UDB=6.00574675; IPR=6.00889358;
 MB=3.00023939; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-28 17:21:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102817-2214-0000-0000-00005C0D59D3
Message-Id: <20181028172142.GN4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810280160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 07:16:53PM -0700, Joel Fernandes (Google) wrote:
> The RCU example for 'rejecting stale data' on system-call auditting
> stops iterating through the rules if a deleted one is found. It makes
> more sense to continue looking at other rules once a deleted one is
> rejected. Although the original example is fine, this makes it more
> meaningful.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Does the actual audit code that this was copied from now include the
continue statement?  If so, please update the commit log to state that
and then I will take the resulting patch.  (This example was inspired
by a long-ago version of the actual audit code.)

							Thanx, Paul

> ---
>  Documentation/RCU/listRCU.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.txt
> index adb5a3782846..09e9a4fc723e 100644
> --- a/Documentation/RCU/listRCU.txt
> +++ b/Documentation/RCU/listRCU.txt
> @@ -250,8 +250,7 @@ as follows:
>  				spin_lock(&e->lock);
>  				if (e->deleted) {
>  					spin_unlock(&e->lock);
> -					rcu_read_unlock();
> -					return AUDIT_BUILD_CONTEXT;
> +					continue;
>  				}
>  				rcu_read_unlock();
>  				return state;
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

