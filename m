Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D194C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 03:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A532213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 03:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A532213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJFKr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 06:47:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727134AbeJFKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 06:47:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w963i0Uv054504
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 23:45:46 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mxk2amx1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:45:46 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 23:45:45 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 23:45:41 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w963jeoA46202932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 6 Oct 2018 03:45:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CDB8B205F;
        Fri,  5 Oct 2018 23:43:48 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48EF1B2064;
        Fri,  5 Oct 2018 23:43:48 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.150.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 23:43:48 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6C5B116C37A7; Fri,  5 Oct 2018 20:45:40 -0700 (PDT)
Date:   Fri, 5 Oct 2018 20:45:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: Re: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Reply-To: paulmck@linux.ibm.com
References: <20181005231815.170433-1-joel@joelfernandes.org>
 <20181005234628.GB2548@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005234628.GB2548@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100603-0060-0000-0000-000002BC1D39
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009827; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098525; UDB=6.00568200; IPR=6.00878565;
 MB=3.00023635; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-06 03:45:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100603-0061-0000-0000-000046BF8036
Message-Id: <20181006034540.GM2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-06_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810060038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 07:46:28PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Oct 05, 2018 at 04:18:09PM -0700, Joel Fernandes (Google) wrote:
> > 
> > Here are this week's rcu doc updates based on combing through whatisRCU and
> > checklists. Hopefully you agree with them. I left several old _bh and _sched
> > API references as is, since I don't think its a good idea to remove them till
> > the APIs themselves are removed, however I did remove several of them as well
> > (like in the first patch in this series) since I feel its better to "encourage"
> > new users not to use the old API.
> 
> Hi Joel,
> 
> As it so happens, I just recently wrote my first RCU patch[1] (file
> systems, especially on-disk data structures, generally tend not to be
> good candidates for RCU semantics).
> 
> [1] http://patchwork.ozlabs.org/patch/979779/

Very cool!

One question...  In the following hunk:

------------------------------------------------------------------------

@@ -5353,9 +5362,13 @@  static int ext4_remount(struct super_block *sb, int *flags, char *data)
 #ifdef CONFIG_QUOTA
 	sbi->s_jquota_fmt = old_opts.s_jquota_fmt;
 	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
-		kfree(sbi->s_qf_names[i]);
-		sbi->s_qf_names[i] = old_opts.s_qf_names[i];
+		to_free[i] = rcu_dereference_protected(sbi->s_qf_names[i],
+						       &sb->s_umount);
+		rcu_assign_pointer(sbi->s_qf_names[i], old_opts.s_qf_names[i]);
 	}
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(to_free[i]);
+	synchronize_rcu();
 #endif
 	kfree(orig_data);
 	return err;

------------------------------------------------------------------------

Shouldn't the synchronize_rcu() precede the loop doing the kfree()
calls?  Or am I missing something subtle?

Otherwise, looks good!  I was worried that seq_show_option() might
sleep, but it looks like it is just putting characters into an
array.  If there is lingering concern, CONFIG_PROVE_LOCKING will
usually catch that sort of thing.

							Thanx, Paul

> So if you are working on improving RCU documentation, I thought I
> would give two comments on the RCU docs from the perspective of a
> developer trying to use RCU for the first time.
> 
> * whatisRCU is great, but one the example in Section 3 uses
>   rcu_dereference_protected() without explaining it.  Given that using
>   that function seems to be considered best practice, maybe a few more
>   words there would be in order?  That function isn't mentioned in
>   rcu.txt either, BTW.
> 
> * lockdep.txt *does* explain what rcu_dereference_protected() does,
>   but it doesn't really describe lockdep_is_held().  You can mostly
>   figure it out from context, but it wasn't obvious to me what locks
>   it could be used against, and in the case of a rw_semaphore, whether
>   it applied to shared as well as exclusive locks.  That's a lockdep
>   abstraction, and not a RCU abstraction, but lockdep isn't
>   particularly well documented, so I ended up spending 20-30 minutes
>   or so looking at the lockdep implementation before I was sure it
>   actually worked the way I thought it was going to.
> 
> Anyway, I was going to put submitting a patch to improve whatisRCU on
> my (vastly over-long) TODO list, but when I saw your patch set, I
> couldn't resist trying to see if I could fob it off on you.  If you
> don't think that's fair (and it probably isn't really), just let me
> know, and I'll put it back on my todo list.  :-)
> 
> Cheers,
> 
> 					- Ted
> 

