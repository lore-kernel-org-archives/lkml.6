Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3284153-1523886735-2-4890057863063373124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523886735; b=g5f1Fndl6QFvP42p8297xxj1AhnrdOgDkRb4geF70WgV9w6cJo
    bpZ7YsnLS7HSdErtDoD0vuWl4prnUkN0j06Hj6vNVAUz7E/LHcK4FBM5S/RUAhSp
    eFZzk9wodqkDUqniuwSOzTJfJuFfQJHk4uxBJ3ucXHIpLKx2ljP7UMph5VIJRNJq
    +rDhk4741dhSmVTC+1IKT/MbZvfpkKaTU13DL73NCtPUDXh79zg1E5QXMBA8n8YH
    bXYJMVs2I3RFE8pLegbxCxlwxea71Ur5qxSN6l4ZUnDPJrKP60aX3p4GQMz52Upt
    6xnHk3D2tfievuTHcC/l5ioCsiX6A41PLNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523886735; bh=d9cwL
    lxzU/1tPaz6HPUyF+I0bvE8yEnbIEE2xQa2jo0=; b=rGkGj/ExOY914Pwc5uN0+
    hBH4t69Rzbz6khNVNN/IfnwL2uqFNxXWynLFxL5lF2BdIpQj/TM1rlE+kOXCfKQE
    SS87G7HykIVhcOue7GJ1bu0Ola4jtl7+JpEaT92Xs0zz1RjVMD/oFgX3h4R8ITpn
    Pe4PPHyLgFCHHajmdxH4nia5e3/cj7L/zY22rtG9iOv6GtBjRsHkQhsRrggnRjDn
    Y/GUsAm8XeXqiwmsKeYTsq+OgJED3FIuhmtD+7JjCgSK3vqTTVjEl1qE+GzEmQ89
    wffsEZqSCZAGiHpqnqrK5sRSfsa+VJ5FjKKhnvHPoC/a0SWuFmqBEJPxz49b8ODM
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=LkI1w2JM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=LkI1w2JM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
X-CM-Envelope: MS4wfCHptNzycBuW9PDEFK+nRy0ydst2/D1+vnwQnfagifBLuXCjqjTvYOZDKO+Iawt00L7cfCWPXFp2v8CWV75rSPqVXlmi7rqZVOmopkzBGAKMzLYuooOY
    b0sarzKLGlPi00R5rrk9w6yTzTVGOvLAyJ++91VR43cq0Exncgoby88F5crFC3wINX7xxBvqg/SQmGrOTWLTMQrJZlCye12SAhCshpcMnh7Dw8XIO/nx/z3/
    U4nI4E6v6pVulKjqyAun5w==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=KkCJoJWLC8lKzCm5n14A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 16 Apr 2018 16:51:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 03/25] staging: lustre: libcfs: implement cfs_cpt_cpumask
 for UMP case
Message-ID: <20180416135157.zg2jwmeutzid3pzn@mwanda>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
 <1523851807-16573-4-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523851807-16573-4-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=925
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160132
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

On Mon, Apr 16, 2018 at 12:09:45AM -0400, James Simmons wrote:
> diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
> index 705abf2..5ea294f 100644
> --- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
> +++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
> @@ -54,6 +54,9 @@ struct cfs_cpt_table *
>  	cptab = kzalloc(sizeof(*cptab), GFP_NOFS);
>  	if (cptab) {
        ^^^^^^^^^^^^
Don't do "success handling", do "error handling".  Success handling
means we have to indent the code and it makes it more complicated to
read.  Ideally code would look like:

	do_this();
	do_that();
	do_the_next_thing();

But because of error handling then we have to add a bunch of if
statements.  It's better when those if statements are very quick and
we can move on.  The success path is all at indent level one still like
and ideal situation above and the the error paths are at indent level
two.

	if (!cptab)
		return NULL;


>  		cptab->ctb_version = CFS_CPU_VERSION_MAGIC;
> +		if (!zalloc_cpumask_var(&cptab->ctb_mask, GFP_NOFS))
> +			return NULL;

This leaks.  It should be:

	if (!zalloc_cpumask_var(&cptab->ctb_mask, GFP_NOFS)) {
		kfree(cptab);
		return NULL;
	}

> +		cpumask_set_cpu(0, cptab->ctb_mask);
>  		node_set(0, cptab->ctb_nodemask);
>  		cptab->ctb_nparts  = ncpt;
>  	}

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
