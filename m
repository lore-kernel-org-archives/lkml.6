Return-Path: <kernel-hardening-return-12403-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuv5dGkCISRzjsvCk45fmd/2c9cX0HdYa14TWsolvmRjStpTw7S/XHJUuM2TccrVdbijiN0
ARC-Seal: i=1; a=rsa-sha256; t=1520805692; cv=none;
        d=google.com; s=arc-20160816;
        b=fNGXcnK/wjFIz80AFzyyA97XTVvdfwYLakF68NBrum91EwWL0sm8c81THh9tiNf4vh
         PvwD16PLBrig4yw6TryvN9jbpKxVGdHWw+raQ0fsMlik0W0ULYXM3li/LXWQ2aCP3/Wr
         Zak0w298rWmOzXAp7hsWbQjRakXGkXsM83GeIU/X3nVVZYDD3braq4igc2XXD94FoSU/
         KJPiwiVL4L4nlPrbIPqTRK9VE6Il1MoDyZltPFRbdX0T5SPzAoO6Zvpci5eHtdpM0Q9+
         vt/HNB31dnJnDQ4CPK6do6uaHrSpiVtknCRVVuth/CivCbfuVsohiFhy25BOSXEca2ok
         XZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=KvdKYAXtS7Nc+olGPcejmU28JNRUhcJuqqghHlDmOYI=;
        b=QiMvgQqIFADUYxNEWfuM9SBTDMXLnQXZr5b+6pis954jRsmxm2Msyqn0RkQ2VgOyHk
         OfYue0oHYe/G6Cfgy8SxNMAq9qoTZwDBk6U9e5pSwPhI0qpA+K2WTsySdGvB8WbtCBEy
         0WIOdmVMekWMku23bpZAaJUdT+GsV+pDSift2tKaSjn0TJKTeCXXbGdXb37M8EDKZRwz
         lYpNLv33odRTnDSOemGdRtLvZRLiaOerd2yEx04ZWoClff699D3rvDINNFWnMdE98p+Z
         u4sgeigq386s57qTpmvD7vJwAY+8AfkIVpCc0EYK07a9WFRKh2JZbtBCaH6z3ODKCRds
         j3mA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12403-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12403-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12403-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12403-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v3] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date: Sun, 11 Mar 2018 18:01:05 -0400
In-Reply-To: <20180308230836.24329-1-tycho@tycho.ws>
References: <20180308230836.24329-1-tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031122-0040-0000-0000-0000041E11F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031122-0041-0000-0000-00002621366E
Message-Id: <1520805665.3547.7.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803110281
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594412861096605696?=
X-GMAIL-MSGID: =?utf-8?q?1594680350052793012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 16:08 -0700, Tycho Andersen wrote:
> In keeping with the directive to get rid of VLAs [1], let's drop the VLA
> from ima_audit_measurement(). We need to adjust the return type of
> ima_audit_measurement, because now this function can fail if an allocation
> fails.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> v2: just use audit_log_format instead of doing a second allocation
> v3: ignore failures in ima_audit_measurement()
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Thanks, this patch has been applied.

Mimi

> ---
>  security/integrity/ima/ima_api.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 08fe405338e1..2aab9170ef68 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -308,14 +308,17 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
>  			   const unsigned char *filename)
>  {
>  	struct audit_buffer *ab;
> -	char hash[(iint->ima_hash->length * 2) + 1];
> +	char *hash;
>  	const char *algo_name = hash_algo_name[iint->ima_hash->algo];
> -	char algo_hash[sizeof(hash) + strlen(algo_name) + 2];
>  	int i;
> 
>  	if (iint->flags & IMA_AUDITED)
>  		return;
> 
> +	hash = kzalloc((iint->ima_hash->length * 2) + 1, GFP_KERNEL);
> +	if (!hash)
> +		return;
> +
>  	for (i = 0; i < iint->ima_hash->length; i++)
>  		hex_byte_pack(hash + (i * 2), iint->ima_hash->digest[i]);
>  	hash[i * 2] = '\0';
> @@ -323,18 +326,19 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
>  	ab = audit_log_start(current->audit_context, GFP_KERNEL,
>  			     AUDIT_INTEGRITY_RULE);
>  	if (!ab)
> -		return;
> +		goto out;
> 
>  	audit_log_format(ab, "file=");
>  	audit_log_untrustedstring(ab, filename);
> -	audit_log_format(ab, " hash=");
> -	snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
> -	audit_log_untrustedstring(ab, algo_hash);
> +	audit_log_format(ab, " hash=\"%s:%s\"", algo_name, hash);
> 
>  	audit_log_task_info(ab, current);
>  	audit_log_end(ab);
> 
>  	iint->flags |= IMA_AUDITED;
> +out:
> +	kfree(hash);
> +	return;
>  }
> 
>  /*
