Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeCYTSw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 15:18:52 -0400
Received: from mail-co1nam03on0068.outbound.protection.outlook.com ([104.47.40.68]:12736
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750782AbeCYTSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 15:18:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Sun, 25 Mar 2018 22:18:27 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: declare rcu_eqs_special_set() in public header
Message-ID: <20180325191827.jgf2eunlyznp2h7w@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-2-ynorov@caviumnetworks.com>
 <20180325191243.GH3675@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325191243.GH3675@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [36.84.65.149]
X-ClientProxiedBy: VI1P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::27) To CY4PR07MB2902.namprd07.prod.outlook.com
 (2603:10b6:903:26::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3195866-a267-4946-af09-08d592853bf0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2902;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2902;3:bksSTspjnUqPXrTYJ7qjVc3W9h4m+O7EYnR6wQhp0XyyEg27bLnLcsBy7DsvjxaT7CfSpckXtLnKHKMq5vZ08fmMHeJ3jcdnTVovY1SkIfH2WUprF9iCjBBY7FEIU/b7ex09/gywHcWiAiyr9sveuLH5QppKXTr7V8HCwiaSZKmgaVxK/LZKRmKycaDyg3q99bIZoYuLelSBSTocVjCaQpZzaYzklMoiwQkvo9HoepHzr1JKIlHFFaMlnydRWIfr;25:3YWd3cgA0AnwrXfFgGspM6ikoY4LTN4yRpB800KnLAekwSuLdZxu0EzOgODou6JAT9JRs+ucH8QVwsd3th7W/kQmkUIdFYWTxI9j9bTP+K7UWkFQpqzYcKg0dss6/1Dj4Lz8OmPG83l3AF6ZR2tWCiS9aUrUI6rE7sFIkZ8E3MQslGGfajRRP8BGjH6KGKQ4O3c4tLtng0J4KrOT8IfsHCJivwvYofDBqm8qwC8gZBBv3PFH+7p2USoxq6jyF3TkERbyLcMsOYY5CnW2Xd3pj7Ms6J7mqKRbn/7WTnwk03Ei4g3vzjHIClkF+ITcjWA8cs6/7cJqD5zWbP4gz4sUYA==;31:TW45AK2+ihEJsBcyJ/n5c2PhaBq85+Dyb5BTcFOE89GSDWA+LuvCkjZScZiouWBaJVFcGSZ5W662hzN15E1vRRa6hhhHrvXj4vBtk400w1xo3TGXML461VZoZuxyp6TiiMEFqei95x8fzlj71Bgq08AHYdT4P9ieT37lqAValaTjUI6JrSIiyVK30xMCYlXWnj4YYsFLhTmxoOR59TnL53bXDcBuGlDZyS8ejyJIHp8=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2902:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2902;20:V6SaOhY6eArHhGUss1gcJTHsP665aFwvatU0+yzpHgGfkosURz2R2dBaZc4AoChNwSPndOaff1irR3YlB1690qMu+/SztfcX7J5hKMWyLwhu2rmA4gkFmc2JevjfOnm3BEnS9xkqEFOcCYyeyd6d8mf+zTxcHiewzjpD8dRAcFsXNqLVcKAAgYcVPV+RHdyxP5x9LPrxxfQcaxVbiewd5/NnAtPL/hbr/E1KfvVVBIKfXtubiyIuiSR9dlIDLsO68AU+21g49V72N8aSle96ubn2N90NTx/djbdRwxvXzRlTMJR+VNNmL0oomruvRIKCtomIbpMbqoZoknNXUQS/5TlcoZU6K+zEaMcpGlijDIL1WGLZoy3JxzFpL9/sW0EzbT6W8lhDUK/Z8P4RjFm9c+T91AlK8rcldxLT659AWMuqnX2RS7A9Pvog/TpGxUtlN7DyEGEJ1qhWU2oefO3f+FpWrmg/0hI4Lc6RPi+XeEvaTyvObTchORHNNxNzVAYqmqENSq4qV/nEkfbT44V/LB+W4XBR3HYy5koTAQE1Gqc5nmHpVeBQgw3B5TgZloek40hxPdwBntUOvHDOUY49riNTK6sZrVPa1m/B03ptlmQ=;4:0vCZV+TOc+j3mYwgcOHZLUeHSZOpxRyyQpgIZsccBVlVW5pD3z/uOfH4SvFBaIUy6Hrv8rvP2iE8DLfLIymjxWxZoswma3Y6if39o3BwmT/ANnXakZntihE74lJtr9RjcrouI+IJcjnK4QaK9wXIaYOaUb4qqytPiFgu9AO5nito/xDEVMypXCBoS824ucr5kPCOwe5tvlTxHUG8tVEKZcCnBolO/pdR6W17xjjQFEjcEtmVNUT5Si3F6iGYqw8NUVmNvhGOh+T3l08YAFdK76wU0tkol51+6gAZhgPedNmg7p6F9DHpSPeqarAErpmB
X-Microsoft-Antispam-PRVS: <CY4PR07MB2902EE60261C1895FD97F8B6E3AE0@CY4PR07MB2902.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(3002001)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB2902;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2902;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(396003)(39380400002)(346002)(376002)(39850400004)(366004)(189003)(199004)(6916009)(9686003)(186003)(16526019)(26005)(53936002)(33716001)(386003)(76506005)(55236004)(42882007)(33896004)(97736004)(105586002)(54906003)(106356001)(76176011)(229853002)(6486002)(72206003)(6246003)(50466002)(16586007)(23726003)(575784001)(5660300001)(6116002)(3846002)(8676002)(2906002)(6496006)(58126008)(316002)(59450400001)(68736007)(478600001)(4326008)(52116002)(8936002)(11346002)(1076002)(81166006)(81156014)(47776003)(6666003)(956004)(66066001)(7736002)(7416002)(446003)(25786009)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2902;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2902;23:Ca/InLWDWNrXYMVSHuqdY3mUTi+D/M1+zr8AHMRvu?=
 =?us-ascii?Q?plWGubmuHiOIt7eYfHmv0thUAxok+UemtGSZtdc7JZI+V7oRu0f9Pefh5ge9?=
 =?us-ascii?Q?jEqvsbq8MPCSDEyJc6Eo+f6A1+eZUZsNTeJs39ig2kQo0kcpv3F5AlR3bXXP?=
 =?us-ascii?Q?CZNQq/lMDXkxEZ6rqlXtrRpicqxSPWhYgj59bPW+9qSQUh5M1gHAkz0dFJca?=
 =?us-ascii?Q?EFTQYkir4t6f2MOP3cdK9D/SY/OYuxDq+V5bnpnTgSSCTw5NkB++TTOjKmUX?=
 =?us-ascii?Q?ws9kVsy80f/rw9l12MAq7jQNtVqDru1lBENadGzZrARj+VV3MqkbwUXbp5yR?=
 =?us-ascii?Q?2A8sPP1DtBbfqYm5cQrTECK5RCUtGXf4+nY/anvtyAVqwrbS4Zpa8t0d7iuO?=
 =?us-ascii?Q?50AMmZRrEMG9wprjQRDvTqghRkY0l16LAy6ZcjA35FtpbR6Z9dV7GV8p74TM?=
 =?us-ascii?Q?aJ3aKUww5HLf79gasdI5JgN2NqEz+bTeZSH6rt1j0uBbPYRBOZT+Rv5bmBR2?=
 =?us-ascii?Q?GiIuayJFz5L9ulbsSjBndDhEUJOSu8CKh2i76YNLG+xHti1gTc6YVqr+prCB?=
 =?us-ascii?Q?0KVUEBtZ3udf6OdeSGh8JSX/smP7gG8R1c2KrjrEOZx0IGvdOPvxfeNlvezv?=
 =?us-ascii?Q?ObxgesOh1PnJY6xoJFEehHihz729lgP+zizIO1CqxDshBWUP0itLSg/FySnW?=
 =?us-ascii?Q?Ut/Nm3rQ80gqNMkoN0MSQJ5iGgoCth2qanlrS2gY1Bxx77gcASDjD9ENLDi/?=
 =?us-ascii?Q?oZtNHpt0kghhIp+JmKUHSENH6BkA2zETvaIhGF9PFKGNojDLole5GjoIIeaE?=
 =?us-ascii?Q?HXsjOFh4zdxRViBjaosWbZ97gPyt1tWCmTvwUmjbqQv1XGGJ1hzr3QK0BxJi?=
 =?us-ascii?Q?S95nBuYpZDPnLOfQ9SEqII6Yh58ysg58xiczqtlUA54n6WZrWdI70d4LhTh5?=
 =?us-ascii?Q?edDT3GE6eymgJMJmZb0iPcgpEF+/m0Er1/Ye8ZBqvcwjVrRys3lxBo8PB3cd?=
 =?us-ascii?Q?ggysjgSJ+fAhffQ0kWWPRSE+1vUgHKE6/86hWZBxBsISW8VAM9NomOaSrwaV?=
 =?us-ascii?Q?/ZKkNO63vwfP6ZM9OveETMpwX3REZqaz/l4SdjJizfEAyp1TAsD0lqg7JdhR?=
 =?us-ascii?Q?ZBDuKA3QrPAPJe4uVzaSnJ/GgwsE12h2bLJTXoMDfSqkBTyS9kB0NEC22UIk?=
 =?us-ascii?Q?tm5mVby+fnReb/4KCXiYCA2ZfrokyEinH1Q+k1iCMz7H4az5jLO4BXyOwKDD?=
 =?us-ascii?Q?athCgg3pAi5z4B7xj7dGFlqB8kpagV3qLPHDKcpqGU+Y/bw9eLQn4gCnTHwq?=
 =?us-ascii?Q?LmRV8bkaK6rY37G/UN/mxxdoLNfs0I551noeDVr67ymjZqua/ufXUoccrvnt?=
 =?us-ascii?Q?e/1fYJeoljCLkAck4KzYyyVrsM=3D?=
X-Microsoft-Antispam-Message-Info: cHxYDEwKO8V5d6Kf20vzBlvJYJnxLNJPHOjQ0i1UXusQCHS9pyafEhu+wrsykRtRSWxzsysj1Pwxje5FU9qchuMmzZs0B51R+thJZceORWxq65fNuWUc0EiMs4ktMkP6GJPIa0CBY/b2hdo5pzdvTsZ+Yis6rAWRIcA5ygSD8sa4TQqyzkoPUD3rSGoBxtNs
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2902;6:lkCOzItK5qOzxG1j+sxGApU65d+67JY3t0xh9NEbmtVhoSq6mMkeLWHo6VbqkaoZus2rMaXP3RcgkiIWffi/QguGIeSJhkk2SqHUr6KIbj4NLEvPeRkMSGLjZKKrxkBvCeRJU7b9duuLIkKWqnJkgE3JiI0WG/eDq8gX8YJYt+uOdERs3kHimpUaOSpVSjm3mbaiZoOkVHPN020thMS2RpHK1iufPdrkHNdeAwbCS3BnQraUC2rQbA1ltZ9TbnmI66ekaD7Aah8UTxLlHEyN8dGqtrjOaErg59BYX5KejFvarTDLRgZePhNGRljsynHBJE4EysYO0524/aHHfkQJ3zz+QprSdIqhpuWVN5z5SIF1VcEYn5PQepyS6rupE1leoKey1jX20OWyoVoadKPVil+9tBAkl5fRMHkkudngW3nCnU1vvyh6VtfeEDcvY3so9Qg8JCdoTGeNlBp4Q/NQaQ==;5:WYUDVSnrcgkZQi8tq3S35RBm51bbMCDws6VEg1WVU/mVC2Za+iUyD/APtcNuR32Tgpg2OvcIwpvzps+YPpctFtRynqXdDXRhKvAKAx9o5tJ2hys68apTfXE1SKMUgVgSsTXjWurYva2vIb7s5HpZ80vT1uOvYGb2HfgNViR6seA=;24:IvI6FRWKGge6H+DpbRJ17QQVxL5KoUtYo/zOt3jwA6Xhb5dfXx/kfpQ2ZVKtiTmLBi7YQk+uQ1m2uuyKNYH75zIEbMRZzuin/PIvgyVQ5aA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2902;7:2VoNAvSUtfMcbsGr/xeH0miD2CMCSwbB0PyuPpJLzq9Zf9V7OVEsC0l4PMwsrCkKrSvwsw1vLdCBHf+vafGmMNRQtg4+IIBHrlAib74BrT2pjR05euMaHHzXMeb8KkzODL4InMPQdC9ZmgGLKdUtax4YiVyUATf/yb5iMAR6Gm/Dpj4YNueOhvmE9Uuk1eqLNuV9fO4gcEjpz8UxTUUNjyiBHeVhs+V47Zy5YpFHiJj9zzBs8EWo/Lu+kPhD6ZpE
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 19:18:45.9228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3195866-a267-4946-af09-08d592853bf0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2902
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 12:12:43PM -0700, Paul E. McKenney wrote:
> On Sun, Mar 25, 2018 at 08:50:03PM +0300, Yury Norov wrote:
> > rcu_eqs_special_set() is declared only in internal header
> > kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h.
> > 
> > This patch declares rcu_eqs_special_set() in include/linux/rcutree.h, so
> > it can be used in non-rcu kernel code.
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  include/linux/rcutree.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > index fd996cdf1833..448f20f27396 100644
> > --- a/include/linux/rcutree.h
> > +++ b/include/linux/rcutree.h
> > @@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
> >  void rcu_barrier(void);
> >  void rcu_barrier_bh(void);
> >  void rcu_barrier_sched(void);
> > +bool rcu_eqs_special_set(int cpu);
> >  unsigned long get_state_synchronize_rcu(void);
> >  void cond_synchronize_rcu(unsigned long oldstate);
> >  unsigned long get_state_synchronize_sched(void);
> 
> Good point, a bit hard to use otherwise.  ;-)
> 
> I removed the declaration from rcutree.h and updated the commit log as
> follows.  Does it look OK?
 
Of course.

Thanks,
Yury
 
> ------------------------------------------------------------------------
> 
> commit 4497105b718a819072d48a675916d9d200b5327f
> Author: Yury Norov <ynorov@caviumnetworks.com>
> Date:   Sun Mar 25 20:50:03 2018 +0300
> 
>     rcu: Declare rcu_eqs_special_set() in public header
>     
>     Because rcu_eqs_special_set() is declared only in internal header
>     kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h, it is
>     inaccessible outside of the RCU implementation.  This patch therefore
>     moves the  rcu_eqs_special_set() declaration to include/linux/rcutree.h,
>     which allows it to be used in non-rcu kernel code.
>     
>     Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index fd996cdf1833..448f20f27396 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
>  void rcu_barrier(void);
>  void rcu_barrier_bh(void);
>  void rcu_barrier_sched(void);
> +bool rcu_eqs_special_set(int cpu);
>  unsigned long get_state_synchronize_rcu(void);
>  void cond_synchronize_rcu(unsigned long oldstate);
>  unsigned long get_state_synchronize_sched(void);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 59ad0e23c722..d5f617aaa744 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -415,7 +415,6 @@ extern struct rcu_state rcu_preempt_state;
>  #endif /* #ifdef CONFIG_PREEMPT_RCU */
>  
>  int rcu_dynticks_snap(struct rcu_dynticks *rdtp);
> -bool rcu_eqs_special_set(int cpu);
>  
>  #ifdef CONFIG_RCU_BOOST
>  DECLARE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
