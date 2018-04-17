Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227858-1523950501-2-11754821134858106021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523950501; b=qoV83wA3Cr1j0VU4RGxNGkwoLwprX05CFlOKdSAief/J8rD/IJ
    p0GrlQ7QqqL6JDGVx8Vk8ZYNtvU+E7MXmOaYCD4jk1A1Hz3gqLILS975eQ5zCSGF
    j01wDuuDLmwHaJ3vXYgjiD8mE9ahfYPR8L1Fj/yV3aI2nrnacFZxBLM4rtmz5DBH
    F8BqqeeplRWOF1PDV1kJizFQAM2EjdYFSiBR2rBvb2lTECQxK3gkAA9CyWURqlB2
    Kr0v8RwScft7G8jAvGJeunb8MdWq63jS6hVGdnZytiX1qreukgiPt8iOpjNmyIpa
    MrpAh+9ZSSb3kcnVFcoscpT3sPmyxuLn2BdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523950501; bh=BRSCc
    gazQQwZLdYG5K5V2IKw5xbg39Xx8YeWDd0XoD4=; b=ceCbQs8LQ++cseMPB6CaG
    ia0S0pmTerjmBAgrnDgkM6NXcxw2Ec3q8k9Wg/J0G88P3XFdygCWK9/wVCtVMrMc
    fMvhx6fOTFTmE/MOp/CPeRbawIBsQ7rjxZvUvSvmso+2sNV/185R0Yx44hTcIH+x
    0Sncsyw/FGFCdWbbCyYyfCsBTMSvG8r5EMFZLX2GBDloVF4JY/dnFMiHz7d8Tkk3
    Pt8Od/VINy1bkc3YPdZjGTaSwHFrpw7pUYlWiXOgmrNUgsU6Rmv4zOH0hbsJlm8c
    V48qcpmMLuKT7EGnCGPbH+CVrp2QyfHudjncQgrT2DiBfqrEzQ7qqGxF5o3gsuYm
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=sH58BMAk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=sH58BMAk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
X-CM-Envelope: MS4wfIaJr2x6erqx3M62r7/jdpOSkK6/pAqE8iEa01jVsImTf3D0bCBpLxxGtrrBR/MpA+3vbOLwQMWQi11thKDdZ3dZaiNfMCZXoJXYt33NS/9sROLe+HNF
    36oGL2woFuy/mJrQ3UutqODD7PETEaUfpUZa0PZnqODjKt+FS6KIy2FvqFJu0VQvyhG6AW00O3aL0yAappb/vUyTvS4p5XyO/dS2N7fn2omwtDI23ERatmem
    K+MGOltyecZOmUaRmdYL4A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=hXEeP0Y-Auu6-BbrflgA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 17 Apr 2018 10:34:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 17/25] staging: lustre: libcfs: rename goto label in
 cfs_cpt_table_print
Message-ID: <20180417073442.5i3h4wz3gvjcnqti@mwanda>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
 <1523851807-16573-18-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523851807-16573-18-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=698
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170068
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

> diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
> index ae5ff58..435ee8e 100644
> --- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
> +++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
> @@ -161,20 +161,20 @@ int cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
>  
>  	for (i = 0; i < cptab->ctb_nparts; i++) {
>  		if (len <= 0)
> -			goto out;
> +			goto err;
>  
>  		rc = snprintf(tmp, len, "%d\t:", i);
>  		len -= rc;
>  
>  		if (len <= 0)
> -			goto out;
> +			goto err;

Labels should say what the goto does.  In this case, it's a do-nothing
goto with a "forgot to set the error code" bug.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
