Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49577C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED78B213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED78B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeJFHOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 03:14:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbeJFHOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 03:14:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9608vvF127391
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 20:13:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mxf4sepyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 20:13:31 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 20:13:30 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 20:13:27 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w960DQDS14876898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 6 Oct 2018 00:13:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB301B206C;
        Fri,  5 Oct 2018 20:11:33 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5649B206E;
        Fri,  5 Oct 2018 20:11:33 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.172])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 20:11:33 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CF05216C37CD; Fri,  5 Oct 2018 17:13:26 -0700 (PDT)
Date:   Fri, 5 Oct 2018 17:13:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: Re: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Reply-To: paulmck@linux.ibm.com
References: <20181005231815.170433-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005231815.170433-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100600-0068-0000-0000-000003486AC7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009826; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098454; UDB=6.00568158; IPR=6.00878494;
 MB=3.00023634; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-06 00:13:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100600-0069-0000-0000-000045F9083E
Message-Id: <20181006001326.GL2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810060001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 04:18:09PM -0700, Joel Fernandes (Google) wrote:
> Hi Paul,
> 
> Here are this week's rcu doc updates based on combing through whatisRCU and
> checklists. Hopefully you agree with them. I left several old _bh and _sched
> API references as is, since I don't think its a good idea to remove them till
> the APIs themselves are removed, however I did remove several of them as well
> (like in the first patch in this series) since I feel its better to "encourage"
> new users not to use the old API.
> 
> Also do you think it makes sense for us to write coccinelle patches to check if
> folks use them on new patches? Btw, I am new to coccinelle but I'd love to give
> it a try, it looks exciting. I remember you saying you wanted to do that, so
> that's something else you could potentially offload to me as you see fit ;-)
> 
> Thank you very much!

Good catches, applied and pushed, thank you!

I updated the commit log and a couple of the patches a bit, so could
you please double-check them?

							Thanx, Paul

> Joel Fernandes (Google) (5):
>   doc: rcu: Update core and full API in whatisRCU
>   doc: rcu: Add more rationale for using rcu_read_lock_sched in
>     checklist
>   doc: rcu: Remove obsolete suggestion from checklist
>   doc: rcu: Remove obsolete checklist item about synchronize_rcu usage
>   doc: rcu: Encourage use of rcu_barrier in checklist
> 
>  Documentation/RCU/checklist.txt | 49 +++++++----------------------
>  Documentation/RCU/whatisRCU.txt | 55 +++++++++++++++++----------------
>  2 files changed, 39 insertions(+), 65 deletions(-)
> 
> -- 
> 2.19.0.605.g01d371f741-goog
> 

