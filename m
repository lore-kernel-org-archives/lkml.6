Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3406967-1523888875-2-17665396725150567968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enrosv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523888874; b=q6V3N/fFX6DSfiszfq1FjFrJag9oB2OMYJsODDPWxdV+Js59F+
    HyAjn60g5kujQ1c+mEOM29j+uEAP+BQYzvCkwxnnLH4YtESDn36ykqa5xVYVNQ6q
    F+MjsN0xDGqf/TsigANYcPx1McXF0bSFXfJML/siao0Hi55MUAmVvZdXXyFiE0Qa
    1+Po/KAi9vI9QUlsiMxO1nHfc7QOZuI4Y2rdwT0e4WZm4eE14G/+wnopKbZvqu53
    tQPG7213ia8fq52nmO9Xhp3ISEAhpnmXArDSWdOU/JlYfhD+RfPhDg8CURXBqT85
    px9BTLU9ZVPBuzBf/QknGhWd03VNHfP2mrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523888874; bh=5z/Qa
    JzPpX2dShQFmel8KMsMDwz7+t0t8Sr+WaGxzWc=; b=D3yrtWx5Fr9K+O2rTBewv
    2+5kNd7ADu4H7RTvd0K2mUmh5RYfVa5CvyQrGZ+clIT1+02VB87VwOsri1/K/rPQ
    +RIVPSUk+mtVHsqxZ5Eadvq0NTcQzengrHmPQAKiqJ7qiQoL/sJwaX2+kqWA9HGv
    cQh5/52WQiEkssaKOCUEKvkDHEaZQyNimsWe5U0knEihDvkaTZD+nN3Uo6HV4vRs
    JFphL+/w9PaOCPRhe4wy4fwc+wFXEkaC1lo0pm4KzxxK2rQLonPmlghQ5ula5yWX
    sSgKCzHNx+Q9nYvjGNjO8VnBH62sZH+jZOV3NUvLTuR9JwLTMrn9lF2VStGjYKZE
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=PSOEK6wk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=PSOEK6wk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBT5ydFIj9b7ZvHDbsf/ofH7SKE8XNj9PPj4LJrzKlKkTuI39bJ2flT4vNlWMMEfPLcGnrOKdkS+p5BURBjjArC/HjWjJCjvHxsouhjfNbp7/sOHFZh/
    rr6Fk1DRe4zcBjFqcMTkGWRnFM8i7jcgro8HrjnYp9ZLfChOyrLcyxNPxlx91JTTPsArf0xcZFyeGaBag4U3LXRs8NbqtriGbGZ+ZMzS4N/ZFTFH26D0hnbt
    oUOH/wli9mLYIY18PqCY/w==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=aR6zTyg2CdjcutoGp5oA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 16 Apr 2018 17:27:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 07/25] staging: lustre: libcfs: NUMA support
Message-ID: <20180416142733.s3f36jdd56rkbfbb@mwanda>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
 <1523851807-16573-8-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523851807-16573-8-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=568
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160136
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, Amir Shehata <amir.shehata@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:09:49AM -0400, James Simmons wrote:
> @@ -114,6 +115,15 @@ struct cfs_cpt_table *
>  	memset(cptab->ctb_cpu2cpt, -1,
>  	       nr_cpu_ids * sizeof(cptab->ctb_cpu2cpt[0]));
>  
> +	cptab->ctb_node2cpt = kvmalloc_array(nr_node_ids,
> +					     sizeof(cptab->ctb_node2cpt[0]),
> +					     GFP_KERNEL);
> +	if (!cptab->ctb_node2cpt)
> +		goto failed;
> +
> +	memset(cptab->ctb_node2cpt, -1,
> +	       nr_node_ids * sizeof(cptab->ctb_node2cpt[0]));
> +
>  	cptab->ctb_parts = kvmalloc_array(ncpt, sizeof(cptab->ctb_parts[0]),
>  					  GFP_KERNEL);
>  	if (!cptab->ctb_parts)


You didn't introduce this, but I was explaining earlier that you should
always be suspicious of code which does "goto failed".  The bug here is
that cptab->ctb_parts is allocated with kvmalloc_array() which
doesn't zero out the memory.  So if we only initialize it part way
because art->cpt_nodemask = kzalloc() fails or something then it's
problem:

    91  void
    92  cfs_cpt_table_free(struct cfs_cpt_table *cptab)
    93  {
    94          int i;
    95  
    96          kvfree(cptab->ctb_cpu2cpt);
    97  
    98          for (i = 0; cptab->ctb_parts && i < cptab->ctb_nparts; i++) {
    99                  struct cfs_cpu_partition *part = &cptab->ctb_parts[i];
   100  
   101                  kfree(part->cpt_nodemask);
                             ^^^^^^^^^^^^^^^^^^^
   102                  free_cpumask_var(part->cpt_cpumask);
                                         ^^^^^^^^^^^^^^^^^
These are uninitialized so it will crash.  It turns out there isn't a
kvcalloc() or kvzalloc_array() function.  We don't seem to have a
vcalloc() either...  Very strange.

   103          }
   104  
   105          kvfree(cptab->ctb_parts);
   106  
   107          kfree(cptab->ctb_nodemask);
   108          free_cpumask_var(cptab->ctb_cpumask);
   109  
   110          kfree(cptab);
   111  }

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
