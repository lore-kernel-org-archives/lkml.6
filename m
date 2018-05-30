Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeE3KGK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:06:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55686 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeE3KGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:06:08 -0400
Date: Wed, 30 May 2018 13:05:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>,
        Amir Shehata <amir.shehata@intel.com>,
        James Simmons <uja.ornl@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH v2 01/25] staging: lustre: libcfs: restore UMP handling
Message-ID: <20180530100529.54jlkfx2q52d7o2a@mwanda>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
 <1527603725-30560-2-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527603725-30560-2-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8908 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=748
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:21:41AM -0400, James Simmons wrote:
> @@ -208,20 +222,52 @@ void cfs_cpt_unset_nodemask(struct cfs_cpt_table *cptab,
>  void cfs_cpu_fini(void);
>  
>  #else /* !CONFIG_SMP */
> -struct cfs_cpt_table;
> -#define cfs_cpt_tab ((struct cfs_cpt_table *)NULL)
>  
> -static inline cpumask_var_t *
> -cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt)
> +static inline void cfs_cpt_table_free(struct cfs_cpt_table *cptab)
>  {
> -	return NULL;
> +	kfree(cptab);
>  }

This should free cptab->ctb_cpumask?

regards,
dan carpenter
