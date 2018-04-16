Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3284153-1523886146-2-13880461896490889363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523886145; b=fWA75myMcaWT0iV0DAzqFC1L+JI2klH8H6DHngoCDbGdJ8mbyr
    8pMC2JJ8ISCcC/9XSyzgfDJC/Naw9HPPxj0YAwXIO0crv67Sf0wifz8A08/NdOfM
    5FPbW7crzncxwnRCajvyJYs4zUGHG52jLj259WfuWwXQjKo9D8aZhsyAKDduAemR
    hzhDyfo/R1gxYOvYpbJ3xNhYriUVCdiZ/XC5eJ7jgFHZikf7JBew36IHft3ykDfu
    tktxvv7HWttFfkR6bzhtOvr9uCRlek7ZmmelQjjqcAOC39rhFOXL69j6DtvRWg5z
    QY++sdSMihOsg7IaQLiP1oZBpV5loX/anIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523886145; bh=luV7K
    xKS8MhOKekJ2KxGPNzCDG98nXzlig71y2FELdI=; b=f97cLy1yykMYuVyJJJYMD
    0skICVXpElCdXQD/f0ySwJ0kxNvNy6+ntONFU6erq0ptXrZ4nPdz1lfnCvZv3gWJ
    EYTsbOpjF2/T2q8xWOyawxmLZ4Okz6BZitJf2+ld+uj4Ge50JG+pCbIdc2DVpFMJ
    Oss0ITWPqxQG8tvF/njtVCyyFKuRUCp5vW6xSFssNgBQmn2HnjdQ5crQQuuXgATh
    CzAs/z7kVrTZ5cP0CEp8IN3QHGhlkSw/IYsOQzFmw1UXAz1qKovkt5U/lte4jWw3
    HMEbi61OATWrvb5kPWKezuIvmGEB/jYSZ3cdKA7vPKGcgBf2kNeMMJkNghRuDn3Z
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jQuow5ey x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jQuow5ey x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAoWakxTxKrdnk0D6W8YSyW+SGnzuhkkYBG2UnxaafBMq+puw5coyBr6zXqez4vAxeIDy0nBqd4Lqtyl2gDE0YckFQWVhzfVnYPW8JDoMitzTh4WigkB
    0WVsnnmRphusJX0RvF0OinR8qJFaSDH6uz7N4SLltbYUoNNWLq9TD+TIHpvRL16oAX1Aj/KTP+AkcpZQcSzu1aLlSekPODSutQc4SJVUNTjXHfZubQq/eFf3
    kzIgpiQTRhWU/Irif5ISOA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=m1KJgCJpBzFEm2K0dikA:9
    a=Bg8NnC7PSEcjXgz_:21 a=PNAKYvrYavHa-9cZ:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 16 Apr 2018 16:42:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 01/25] staging: lustre: libcfs: remove useless CPU
 partition code
Message-ID: <20180416134203.ehtebtyes34p2tsm@mwanda>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
 <1523851807-16573-2-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523851807-16573-2-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=973
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160130
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
Cc: devel@driverdev.osuosl.org, Dmitry Eremin <dmitry.eremin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:09:43AM -0400, James Simmons wrote:
> @@ -1033,6 +953,7 @@ static int cfs_cpu_dead(unsigned int cpu)
>  #endif
>  	ret = -EINVAL;
>  
> +	get_online_cpus();
>  	if (*cpu_pattern) {
>  		char *cpu_pattern_dup = kstrdup(cpu_pattern, GFP_KERNEL);
>  
> @@ -1058,13 +979,7 @@ static int cfs_cpu_dead(unsigned int cpu)
>  		}
>  	}
>  
> -	spin_lock(&cpt_data.cpt_lock);
> -	if (cfs_cpt_table->ctb_version != cpt_data.cpt_version) {
> -		spin_unlock(&cpt_data.cpt_lock);
> -		CERROR("CPU hotplug/unplug during setup\n");
> -		goto failed;
> -	}
> -	spin_unlock(&cpt_data.cpt_lock);
> +	put_online_cpus();
>  
>  	LCONSOLE(0, "HW nodes: %d, HW CPU cores: %d, npartitions: %d\n",
>  		 num_online_nodes(), num_online_cpus(),
> @@ -1072,6 +987,7 @@ static int cfs_cpu_dead(unsigned int cpu)
>  	return 0;
>  
>   failed:
> +	put_online_cpus();
>  	cfs_cpu_fini();
>  	return ret;
>  }

When you have a one label called "failed" then I call that "one err"
style error handling and it's the most bug prone style of error handling
to use.  Always be suspicious of code that uses a "err:" labels.

The bug here is typical.  We are calling put_online_cpus() on paths
where we didn't call get_online_cpus().

The best way to do error handling is to keep track of each resource that
was allocated and then only free the things that have been allocated.
Also the label name should indicate what was freed.  Generally avoid
magic, opaque functions like cfs_cpu_fini().  As a reviewer, it's
harder for me to check that cfs_cpu_fini() frees everything correctly
instead of the a normal list of frees like:

free_table:
	cfs_cpt_table_free(cfs_cpt_table);
free_hotplug_stuff:
	cpuhp_remove_state_nocalls(lustre_cpu_online);
set_state_dead:
	cpuhp_remove_state_nocalls(CPUHP_LUSTRE_CFS_DEAD);

When I'm reading the code, and I see a "goto free_table;", I only need
to ask, "Was table the most recently allocated resource?"  If yes, then
the code is correct, if no then it's buggy.  It's simple review.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
