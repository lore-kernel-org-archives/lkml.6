Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA9DC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526C32157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526C32157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeI0Kod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:44:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbeI0Kod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:44:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8R4OtZF043453
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:28:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrmn2ykmw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:28:18 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Sep 2018 00:28:17 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 00:28:13 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8R4SCDM21692530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 04:28:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E710B2068;
        Thu, 27 Sep 2018 00:26:32 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA837B2065;
        Thu, 27 Sep 2018 00:26:31 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 00:26:31 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AF9A416C3FCC; Wed, 26 Sep 2018 16:47:40 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:47:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [0/5] rcu doc updates
Reply-To: paulmck@linux.ibm.com
References: <20180925182601.37421-1-joel@joelfernandes.org>
 <CAEXW_YTjjfZhH6rpOArSVub_XhC4mvbKn6Rf0DSiy=rAHQGzPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTjjfZhH6rpOArSVub_XhC4mvbKn6Rf0DSiy=rAHQGzPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092704-0040-0000-0000-000004770948
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009778; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094226; UDB=6.00565617; IPR=6.00874261;
 MB=3.00023523; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-27 04:28:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092704-0041-0000-0000-0000087F0EBB
Message-Id: <20180926234740.GN4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=887 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:49:10AM -0700, Joel Fernandes wrote:
> On Tue, Sep 25, 2018 at 11:26 AM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > Hi Paul,
> > These patches are documentation updates for the rcu_dynticks rolling into
> > rcu_data and also the updates to the fact that there's a single rcu_state now.
> > Its based on your rcu/dev branch.
> >
> > Next I'm thinking of tackling 'RCU Callback Handling' and further digging into
> > the dyntick handling and then dig into other documents outside of
> > Data-Structure that need updates. But let me know any suggestions.
> > Thanks!
> 
> Apologies that my scripts missed the 'PATCH' prefix. Hopefully that's
> Ok for this time, but let me know if you'd like me to resend them!
> Thanks!

I will let it go this time.  ;-)

Queued, thank you very much!  I will push them out when I get to a
reliable network connection.

I made a few adjustments to wording, so please double-check.  You
should be able to just diff against your original patches.

							Thanx, Paul

