Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3398102-1523889965-2-17442348986751377744
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
    1523889964; b=TpXw75tr++kEGYyDYJJoacYMWavoOIzK8t1Mk3AfEkUJtyETg4
    IWZRFD4zElxaOP86OM+KZxJb7RlA3vLshqpwtG9AYQBmA+HqRh50T5ystSTszD9h
    9eoW7Q02AYvJ+C5ZRM3F6JNpu+svaQd9sy873Hg6nqTfi/CSipB4QHwI88wp2tW2
    65lEFBhuy4LR2fouzq12SCTQI8X87pL97FrNUbo3gYzMX5N06kbtIi9Ff3OrjO6w
    u74jW6I8AJb7VlhNLde5Oc3Zt1AlbOgOoNuGqkrawuQifYmA+mJv26xuvGKaaviI
    vvUFzey49CjHhKaTNNC6ohJWCQyuxwTGpqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523889964; bh=2Hk4W
    ZM5K2hujX4CUTEJutcz6fR95J5aWhQG9VGXsJM=; b=sFie5xizW+RyzXpd6IRDi
    HnqMEqTgiK/jjhi5kpquyoJ93jG71gjG18ReaUhqzIT7dZEQr4KhN8vP9VLr20ZH
    AFkH3buI2PmzlTSchwUrKSebAJN04NO7mHX2v1DR8dCzOAGXcdohc9vmm/OMmfXr
    lCADR3gI9LlvZdcZ/3qAKouXxhDVBpyiG2+aWF7HU8QRdvJvgcaeATgkgf9AsUn0
    Unn8g+lZ1pt9HP0BB1Q27VaC3AUShmlWDawppVGKU1dWM3yfAFD8A03v1gPxafJ9
    2NujmCieV776PjJ+jYecimnXaGIOjfPMUaa+7qlGGhtps3OUzfvTLhMZuvM+oGCd
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=AcbdyW8Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=AcbdyW8Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
X-CM-Envelope: MS4wfB4O2BC2le1IyzU1KyAr9D24T0S+CvbJYITzNnPMYV+iYbAU27a0b3ZOW5Fm5dRwGGPDshDrTpWGTRtgyBOtyLJ2oiE1OyPJHUqiPr/dhANnNxSJaQoh
    30aKtO4HRQLRQXNbTONMpZdRbLNB1j0pLI+Fp89vmqoM4nvhdLrTfo6YmwdZhAnHqGJOADjgmMUcHMKB1MT2mT2jW9EqPcOtqyD5uvTE00B3CjjHSTBwxqqw
    pD9qo1+NS40Ad4DR51DWrQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=9spVqeRJlErd6WzYC-IA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 16 Apr 2018 17:45:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 08/25] staging: lustre: libcfs: add cpu distance handling
Message-ID: <20180416144548.xjjcaxivkbvynsux@mwanda>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
 <1523851807-16573-9-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523851807-16573-9-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=436
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160139
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

On Mon, Apr 16, 2018 at 12:09:50AM -0400, James Simmons wrote:
> +int cfs_cpt_distance_print(struct cfs_cpt_table *cptab, char *buf, int len)
> +{
> +	char *tmp = buf;
> +	int rc = -EFBIG;
> +	int i;
> +	int j;
> +
> +	for (i = 0; i < cptab->ctb_nparts; i++) {
> +		if (len <= 0)
> +			goto err;
> +
> +		rc = snprintf(tmp, len, "%d\t:", i);
> +		len -= rc;
> +
> +		if (len <= 0)
> +			goto err;


The "goto err" here is sort of an example of a "do-nothing" goto.  There
are no resources to free or anything like that.

I don't like do-nothing gotos because "return -EFBIG;" is self
documenting code and "goto err;" is totally ambiguous what it does.  The
second problem is that do-nothing error labels easily turn into
do-everything one err style error paths which I loath.  And the third
problem is that they introduce "forgot to set the error code" bugs.

It looks like we forgot to set the error code here although it's also
possible that was intended.  This code is ambiguous.

> +
> +		tmp += rc;
> +		for (j = 0; j < cptab->ctb_nparts; j++) {
> +			rc = snprintf(tmp, len, " %d:%d",
> +				      j, cptab->ctb_parts[i].cpt_distance[j]);
> +			len -= rc;
> +			if (len <= 0)
> +				goto err;
> +			tmp += rc;
> +		}
> +
> +		*tmp = '\n';
> +		tmp++;
> +		len--;
> +	}
> +	rc = 0;
> +err:
> +	if (rc < 0)
> +		return rc;
> +
> +	return tmp - buf;
> +}

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
