Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227857-1523949310-2-8968845966890387719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523949309; b=VsAiCptjpqkWQacszr9Mfj1xw0066iOEFVBjWy1RUZfXEfNoY7
    EQQFnteHnOtinThS3y3CadGXHRoYmTyMaqWR0kBtSVl8zsWF1zXD9bUQVFqxfBmj
    hNfvCkihkWYU+7i03JBpw0mZcyKuvmS79Wwf/ppfLRQRmpljJ6ANlMvbUC7WepK/
    OYEF1SJPPbvNC2prbs/ejNHlmtb4kEBIN6u5+fXsa9ZtuSEknvfrf8OFLfS5dksE
    19hgKrk1Q3le2Pt2PQnlaPKUqv/29Fe1bEN8hXMS2iTqzD6bVMjUl+rvP+uCawc9
    q6hVWsT7/AmAV2eeFFfyh76BObsjGbBzHWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523949309; bh=afQK0
    AQ79LVBV2sIxc2uPwDnFS3KIju7FvpNi363iqo=; b=BNd+WldEjyX+fhTyBm6gC
    /qo3/oRmBLSjRlOGw3cUdsLs/KxNUax4tqk/HQKJOce2E+Kn1fOW7n6KXtAjZe61
    hvEKnvf6fDKWmY36OQhQFq34EkzNsj8PUrUvw73cKSwRJK3JLv9Rk1z2Z4awcw8Q
    EeOSD1luV1+hS/FJAS+ouF8+A8MB5eu7cx+hUVDxpDOdJHkvX+mfD+iMULBk1wvs
    duMSagcj5khz/ImoDWeiv/LBhFcaF+6SS713KRRTcLovT42Z7wk9bs3tnaiez/du
    /zv26Xa+TZMbJcqKgPa4baxkIFXbu4nBtfXHyRuVFAF4g7GGIQMTjUAj4DQi/21g
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jSZv69ub x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jSZv69ub x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLw7cHzz4BEw3WFbD3pmxjLcehSXXj/rnwqqRju5d8aVFGtiwrAoOIsUxyAxVWIBvY9+pwMNHnTzKUGSET4Yj5MKDNMz7yRpU5fZ9EWyMoSQ3FvkgrY2
    gPgoXTpUp6ch16g90C/XBIIgrO9UmAx25HeOTvnPDFd+1yYyBsQxeZcx2BtUWjhbOxaa7f3Uyzi0qGlNilpq4OG/9JfEZI5CBU0saCR/vnki7ZP1wHO8nLJT
    bisSmTxOja6uqgYMI2yO5A==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=eJfxgxciAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=57tVNdP5g-pHYH0rNp4A:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 17 Apr 2018 10:14:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 11/25] staging: lustre: libcfs: invert error handling for
 cfs_cpt_table_print
Message-ID: <20180417071449.ufj7spey44qwiqdy@mwanda>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
 <1523851807-16573-12-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523851807-16573-12-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170066
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

On Mon, Apr 16, 2018 at 12:09:53AM -0400, James Simmons wrote:
> From: Amir Shehata <amir.shehata@intel.com>
> 
> Instead of setting rc to -EFBIG for several cases in the loop lets
> initialize rc to -EFBIG and just break out of the loop in case of
> failure. Just set rc to zero once we successfully finish the loop.
> 
> Signed-off-by: Amir Shehata <amir.shehata@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
> Reviewed-on: http://review.whamcloud.com/18916
> Reviewed-by: Olaf Weber <olaf@sgi.com>
> Reviewed-by: Doug Oucharek <dougso@me.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>
> ---
>  .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
> index bbf89b8..6d8dcd3 100644
> --- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
> +++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
> @@ -158,29 +158,26 @@ struct cfs_cpt_table *
>  cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
>  {
>  	char *tmp = buf;
> -	int rc = 0;
> +	int rc = -EFBIG;
>  	int i;
>  	int j;
>  
>  	for (i = 0; i < cptab->ctb_nparts; i++) {
> -		if (len > 0) {
> -			rc = snprintf(tmp, len, "%d\t:", i);
> -			len -= rc;
> -		}
> +		if (len <= 0)
> +			goto out;
> +
> +		rc = snprintf(tmp, len, "%d\t:", i);
> +		len -= rc;
>  
> -		if (len <= 0) {
> -			rc = -EFBIG;
> +		if (len <= 0)
>  			goto out;

This patch says it's a cleanup but the only thing it does is introduce
"forgot to set the error" bugs.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
