Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CCAC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0141217CF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVmQlphv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0141217CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeHMAxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 20:53:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeHMAxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 20:53:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7CM9Q1X161933;
        Sun, 12 Aug 2018 22:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=beQrgrn9MqIfgK/+WAsG4+6E4Y3Xwx1HuMFGV8kCUUA=;
 b=SVmQlphv5SFfaMxCHB7Irb/b03OklcHV0zOtIc1GmPfWPYBA78snOgk8JU9BIxrsOWs/
 bBD58fc3+iUxhQFHQS7LCcHRdeOZGQEwNrHv2uPr4WwtEfqWdGCAaXTz2dNgKrYO22mh
 jQN5CxIhEvFAiHSKaIA7c2UWgoPG550TAXLDYgfhBLXmogYN7xFR0FzGdoYE19nS3EW7
 iaZ+3RSIM0HVMQS6gRjiz8hYHZ/hMWLzyqjmTuhuKFqwlCj0tmSdNHtXaVf6DRFb+nH0
 79KAxUvHvG82pX4DwnZW2H76LMq3MWu+tiTVsaEX0XPOUjh5O/qi4tnppY6I8gkerA8C /g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2ksqrp2402-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Aug 2018 22:13:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7CMDoBH032549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Aug 2018 22:13:50 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7CMDleb007241;
        Sun, 12 Aug 2018 22:13:49 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Aug 2018 15:13:47 -0700
Date:   Mon, 13 Aug 2018 01:13:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@01.org, Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180812221338.vwyorgitaqxkbldg@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1951009.1jlQfyrxio@aspire.rjw.lan>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808120247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

I love your patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Rafael-J-Wysocki/cpuidle-menu-Handle-stopped-tick-more-aggressively/20180811-191914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

smatch warnings:
drivers/cpuidle/governors/menu.c:374 menu_select() error: uninitialized symbol 'first_idx'.

# https://github.com/0day-ci/linux/commit/5f9f09809ebd1b4f7820c9925a0cbd417bd3a823
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 5f9f09809ebd1b4f7820c9925a0cbd417bd3a823
vim +/first_idx +374 drivers/cpuidle/governors/menu.c

1f85f87d4 Arjan van de Ven              2010-05-24  276  
4f86d3a8e Len Brown                     2007-10-03  277  /**
4f86d3a8e Len Brown                     2007-10-03  278   * menu_select - selects the next idle state to enter
46bcfad7a Deepthi Dharwar               2011-10-28  279   * @drv: cpuidle driver containing state data
4f86d3a8e Len Brown                     2007-10-03  280   * @dev: the CPU
45f1ff59e Rafael J. Wysocki             2018-03-22  281   * @stop_tick: indication on whether or not to stop the tick
4f86d3a8e Len Brown                     2007-10-03  282   */
45f1ff59e Rafael J. Wysocki             2018-03-22  283  static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
45f1ff59e Rafael J. Wysocki             2018-03-22  284  		       bool *stop_tick)
4f86d3a8e Len Brown                     2007-10-03  285  {
229b6863b Christoph Lameter             2014-08-17  286  	struct menu_device *data = this_cpu_ptr(&menu_devices);
0fc784fb0 Rafael J. Wysocki             2018-05-30  287  	int latency_req = cpuidle_governor_latency_req(dev->cpu);
4f86d3a8e Len Brown                     2007-10-03  288  	int i;
3ed09c945 Nicholas Piggin               2017-06-26  289  	int first_idx;
3ed09c945 Nicholas Piggin               2017-06-26  290  	int idx;
96e95182e tuukka.tikkanen@linaro.org    2014-02-24  291  	unsigned int interactivity_req;
e132b9b3b Rik van Riel                  2016-03-16  292  	unsigned int expected_interval;
372ba8cb4 Mel Gorman                    2014-08-06  293  	unsigned long nr_iowaiters, cpu_load;
296bb1e51 Rafael J. Wysocki             2018-04-05  294  	ktime_t delta_next;
4f86d3a8e Len Brown                     2007-10-03  295  
672917dcc Corrado Zoccolo               2009-09-21  296  	if (data->needs_update) {
46bcfad7a Deepthi Dharwar               2011-10-28  297  		menu_update(drv, dev);
672917dcc Corrado Zoccolo               2009-09-21  298  		data->needs_update = 0;
672917dcc Corrado Zoccolo               2009-09-21  299  	}
672917dcc Corrado Zoccolo               2009-09-21  300  
69d25870f Arjan van de Ven              2009-09-21  301  	/* Special case when user has set very strict latency requirement */
45f1ff59e Rafael J. Wysocki             2018-03-22  302  	if (unlikely(latency_req == 0)) {
45f1ff59e Rafael J. Wysocki             2018-03-22  303  		*stop_tick = false;
a2bd92023 venkatesh.pallipadi@intel.com 2008-07-30  304  		return 0;
45f1ff59e Rafael J. Wysocki             2018-03-22  305  	}
a2bd92023 venkatesh.pallipadi@intel.com 2008-07-30  306  
69d25870f Arjan van de Ven              2009-09-21  307  	/* determine the expected residency time, round up */
296bb1e51 Rafael J. Wysocki             2018-04-05  308  	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
69d25870f Arjan van de Ven              2009-09-21  309  
5f9f09809 Rafael J. Wysocki             2018-08-10  310  	/*
5f9f09809 Rafael J. Wysocki             2018-08-10  311  	 * If the tick is already stopped, the cost of possible short idle
5f9f09809 Rafael J. Wysocki             2018-08-10  312  	 * duration misprediction is much higher, because the CPU may be stuck
5f9f09809 Rafael J. Wysocki             2018-08-10  313  	 * in a shallow idle state for a long time as a result of it.  In that
5f9f09809 Rafael J. Wysocki             2018-08-10  314  	 * case say we might mispredict and use the known time till the closest
5f9f09809 Rafael J. Wysocki             2018-08-10  315  	 * timer event for the idle state selection.
5f9f09809 Rafael J. Wysocki             2018-08-10  316  	 */
5f9f09809 Rafael J. Wysocki             2018-08-10  317  	if (tick_nohz_tick_stopped()) {
5f9f09809 Rafael J. Wysocki             2018-08-10  318  		data->predicted_us = ktime_to_us(delta_next);
5f9f09809 Rafael J. Wysocki             2018-08-10  319  		goto select;
                                                                        ^^^^^^^^^^^
We hit this goto

5f9f09809 Rafael J. Wysocki             2018-08-10  320  	}
5f9f09809 Rafael J. Wysocki             2018-08-10  321  
372ba8cb4 Mel Gorman                    2014-08-06  322  	get_iowait_load(&nr_iowaiters, &cpu_load);
64b4ca5cb Mel Gorman                    2014-08-06  323  	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
69d25870f Arjan van de Ven              2009-09-21  324  
69d25870f Arjan van de Ven              2009-09-21  325  	/*
51f245b89 Tuukka Tikkanen               2013-08-14  326  	 * Force the result of multiplication to be 64 bits even if both
51f245b89 Tuukka Tikkanen               2013-08-14  327  	 * operands are 32 bits.
51f245b89 Tuukka Tikkanen               2013-08-14  328  	 * Make sure to round up for half microseconds.
51f245b89 Tuukka Tikkanen               2013-08-14  329  	 */
ee3c86f35 Javi Merino                   2015-04-16  330  	data->predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
51f245b89 Tuukka Tikkanen               2013-08-14  331  					 data->correction_factor[data->bucket],
69d25870f Arjan van de Ven              2009-09-21  332  					 RESOLUTION * DECAY);
69d25870f Arjan van de Ven              2009-09-21  333  
e132b9b3b Rik van Riel                  2016-03-16  334  	expected_interval = get_typical_interval(data);
e132b9b3b Rik van Riel                  2016-03-16  335  	expected_interval = min(expected_interval, data->next_timer_us);
96e95182e tuukka.tikkanen@linaro.org    2014-02-24  336  
dc2251bf9 Rafael J. Wysocki             2017-08-23  337  	first_idx = 0;
dc2251bf9 Rafael J. Wysocki             2017-08-23  338  	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
dc2251bf9 Rafael J. Wysocki             2017-08-23  339  		struct cpuidle_state *s = &drv->states[1];
0c313cb20 Rafael J. Wysocki             2016-03-20  340  		unsigned int polling_threshold;
0c313cb20 Rafael J. Wysocki             2016-03-20  341  
96e95182e tuukka.tikkanen@linaro.org    2014-02-24  342  		/*
69d25870f Arjan van de Ven              2009-09-21  343  		 * We want to default to C1 (hlt), not to busy polling
e132b9b3b Rik van Riel                  2016-03-16  344  		 * unless the timer is happening really really soon, or
e132b9b3b Rik van Riel                  2016-03-16  345  		 * C1's exit latency exceeds the user configured limit.
69d25870f Arjan van de Ven              2009-09-21  346  		 */
0c313cb20 Rafael J. Wysocki             2016-03-20  347  		polling_threshold = max_t(unsigned int, 20, s->target_residency);
0c313cb20 Rafael J. Wysocki             2016-03-20  348  		if (data->next_timer_us > polling_threshold &&
0c313cb20 Rafael J. Wysocki             2016-03-20  349  		    latency_req > s->exit_latency && !s->disabled &&
dc2251bf9 Rafael J. Wysocki             2017-08-23  350  		    !dev->states_usage[1].disable)
dc2251bf9 Rafael J. Wysocki             2017-08-23  351  			first_idx = 1;
9c4b2867e Rafael J. Wysocki             2016-01-14  352  	}
4f86d3a8e Len Brown                     2007-10-03  353  
71abbbf85 Ai Li                         2010-08-09  354  	/*
e132b9b3b Rik van Riel                  2016-03-16  355  	 * Use the lowest expected idle interval to pick the idle state.
e132b9b3b Rik van Riel                  2016-03-16  356  	 */
e132b9b3b Rik van Riel                  2016-03-16  357  	data->predicted_us = min(data->predicted_us, expected_interval);
e132b9b3b Rik van Riel                  2016-03-16  358  
e132b9b3b Rik van Riel                  2016-03-16  359  	/*
5f9f09809 Rafael J. Wysocki             2018-08-10  360  	 * Use the performance multiplier and the user-configurable latency_req
5f9f09809 Rafael J. Wysocki             2018-08-10  361  	 * to determine the maximum exit latency.
e132b9b3b Rik van Riel                  2016-03-16  362  	 */
e132b9b3b Rik van Riel                  2016-03-16  363  	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
e132b9b3b Rik van Riel                  2016-03-16  364  	if (latency_req > interactivity_req)
e132b9b3b Rik van Riel                  2016-03-16  365  		latency_req = interactivity_req;
e132b9b3b Rik van Riel                  2016-03-16  366  
5f9f09809 Rafael J. Wysocki             2018-08-10  367  select:
45f1ff59e Rafael J. Wysocki             2018-03-22  368  	expected_interval = data->predicted_us;
e132b9b3b Rik van Riel                  2016-03-16  369  	/*
71abbbf85 Ai Li                         2010-08-09  370  	 * Find the idle state with the lowest power while satisfying
71abbbf85 Ai Li                         2010-08-09  371  	 * our constraints.
71abbbf85 Ai Li                         2010-08-09  372  	 */
3ed09c945 Nicholas Piggin               2017-06-26  373  	idx = -1;
3ed09c945 Nicholas Piggin               2017-06-26 @374  	for (i = first_idx; i < drv->state_count; i++) {
                                                                     ^^^^^^^^^^^^^^
This is uninitialized

46bcfad7a Deepthi Dharwar               2011-10-28  375  		struct cpuidle_state *s = &drv->states[i];
dc7fd275a ShuoX Liu                     2012-07-03  376  		struct cpuidle_state_usage *su = &dev->states_usage[i];
4f86d3a8e Len Brown                     2007-10-03  377  
cbc9ef028 Rafael J. Wysocki             2012-07-03  378  		if (s->disabled || su->disable)
3a53396b0 ShuoX Liu                     2012-03-28  379  			continue;
3ed09c945 Nicholas Piggin               2017-06-26  380  		if (idx == -1)
3ed09c945 Nicholas Piggin               2017-06-26  381  			idx = i; /* first enabled state */
148519120 Rafael J. Wysocki             2013-07-27  382  		if (s->target_residency > data->predicted_us)
8e37e1a2a Alex Shi                      2017-01-12  383  			break;
45f1ff59e Rafael J. Wysocki             2018-03-22  384  		if (s->exit_latency > latency_req) {
45f1ff59e Rafael J. Wysocki             2018-03-22  385  			/*
45f1ff59e Rafael J. Wysocki             2018-03-22  386  			 * If we break out of the loop for latency reasons, use
45f1ff59e Rafael J. Wysocki             2018-03-22  387  			 * the target residency of the selected state as the
45f1ff59e Rafael J. Wysocki             2018-03-22  388  			 * expected idle duration so that the tick is retained
45f1ff59e Rafael J. Wysocki             2018-03-22  389  			 * as long as that target residency is low enough.
45f1ff59e Rafael J. Wysocki             2018-03-22  390  			 */
45f1ff59e Rafael J. Wysocki             2018-03-22  391  			expected_interval = drv->states[idx].target_residency;
8e37e1a2a Alex Shi                      2017-01-12  392  			break;
45f1ff59e Rafael J. Wysocki             2018-03-22  393  		}
3ed09c945 Nicholas Piggin               2017-06-26  394  		idx = i;
71abbbf85 Ai Li                         2010-08-09  395  	}
4f86d3a8e Len Brown                     2007-10-03  396  
3ed09c945 Nicholas Piggin               2017-06-26  397  	if (idx == -1)
3ed09c945 Nicholas Piggin               2017-06-26  398  		idx = 0; /* No states enabled. Must use 0. */
3ed09c945 Nicholas Piggin               2017-06-26  399  
45f1ff59e Rafael J. Wysocki             2018-03-22  400  	/*
45f1ff59e Rafael J. Wysocki             2018-03-22  401  	 * Don't stop the tick if the selected state is a polling one or if the
45f1ff59e Rafael J. Wysocki             2018-03-22  402  	 * expected idle duration is shorter than the tick period length.
45f1ff59e Rafael J. Wysocki             2018-03-22  403  	 */
5f9f09809 Rafael J. Wysocki             2018-08-10  404  	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
5f9f09809 Rafael J. Wysocki             2018-08-10  405  	    expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
296bb1e51 Rafael J. Wysocki             2018-04-05  406  		unsigned int delta_next_us = ktime_to_us(delta_next);
296bb1e51 Rafael J. Wysocki             2018-04-05  407  
45f1ff59e Rafael J. Wysocki             2018-03-22  408  		*stop_tick = false;
45f1ff59e Rafael J. Wysocki             2018-03-22  409  
5f9f09809 Rafael J. Wysocki             2018-08-10  410  		if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
296bb1e51 Rafael J. Wysocki             2018-04-05  411  			/*
296bb1e51 Rafael J. Wysocki             2018-04-05  412  			 * The tick is not going to be stopped and the target
296bb1e51 Rafael J. Wysocki             2018-04-05  413  			 * residency of the state to be returned is not within
296bb1e51 Rafael J. Wysocki             2018-04-05  414  			 * the time until the next timer event including the
296bb1e51 Rafael J. Wysocki             2018-04-05  415  			 * tick, so try to correct that.
296bb1e51 Rafael J. Wysocki             2018-04-05  416  			 */
296bb1e51 Rafael J. Wysocki             2018-04-05  417  			for (i = idx - 1; i >= 0; i--) {
296bb1e51 Rafael J. Wysocki             2018-04-05  418  			    if (drv->states[i].disabled ||
296bb1e51 Rafael J. Wysocki             2018-04-05  419  			        dev->states_usage[i].disable)
296bb1e51 Rafael J. Wysocki             2018-04-05  420  					continue;
296bb1e51 Rafael J. Wysocki             2018-04-05  421  
296bb1e51 Rafael J. Wysocki             2018-04-05  422  				idx = i;
296bb1e51 Rafael J. Wysocki             2018-04-05  423  				if (drv->states[i].target_residency <= delta_next_us)
296bb1e51 Rafael J. Wysocki             2018-04-05  424  					break;
296bb1e51 Rafael J. Wysocki             2018-04-05  425  			}
296bb1e51 Rafael J. Wysocki             2018-04-05  426  		}
296bb1e51 Rafael J. Wysocki             2018-04-05  427  	}
296bb1e51 Rafael J. Wysocki             2018-04-05  428  
3ed09c945 Nicholas Piggin               2017-06-26  429  	data->last_state_idx = idx;
3ed09c945 Nicholas Piggin               2017-06-26  430  
69d25870f Arjan van de Ven              2009-09-21  431  	return data->last_state_idx;
4f86d3a8e Len Brown                     2007-10-03  432  }
4f86d3a8e Len Brown                     2007-10-03  433  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
