Return-Path: <kernel-hardening-return-12258-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELslXun+Y6St9EHoux9nbjJ+zredZw6pTYVTrnTYEtJsgLcdSj+SGREJLJ8H9hTgf7KKDwqd
ARC-Seal: i=1; a=rsa-sha256; t=1520541399; cv=none;
        d=google.com; s=arc-20160816;
        b=zUIB1DT3VkTd5vGdrqx+hCCZu3/WIHicKsBlCuU0/3ZPMz/fLo6ZTUY0EgfG3gY0wb
         oUB2dGzuCbmNux9R/G0YrRJkxwCwZax6s/dznUNJGp0HyqIteishybS5DS8VqRKXxPgh
         GKASW2r9F96KVvy8v9oS9X4ZJDuKIFzixAW1hWWIgnkEDZNuGF/RH1YFNpb6UpjL9Z04
         P17gXxw6AC+93WW2O84/+A7nFwa8cFH/qSeGJknwiSlo/3PRq/AJqRr6ZfhXUH7O0zyw
         tpFJNvHDZaWbHywH3aJCZeIQF8bJ3d6QQiUW2EdJL4reDuzX4nZ2JeVyj3c5eMJ1VNbQ
         z4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=nf+1VPtgJDKbrO3IfAw74u+HLZ3yhT4bliuZLMmAyc0=;
        b=TyXWEyvZHwWLEW6+k5W7rNj2F2KbsYgkDae8iVJ2C/OVH9B/k5McC8hcBvoRqrBm7u
         R2s1wL3Xu4p9Agp9S0Emru6U+08W/hzrgWqzKO0n/y957BVT7CqRK7VniTocVON92eeO
         rdISjraAAFB+MBp1DIxgJg1yFD+2LfHqpiUOweejp/9aGI6LU5s15TBJZO0qbv/MAQj9
         dnkx80o7k8cScrs5s0vgg+L4w+M46sIND85HeuH2pFACNqnob7CIic0lD5Z+giT6deAg
         MRRT/7ruCPbLgVVYiXpa9x/uRf9AEXrxhyVZxNcHigB3sGqx1TCX4DdyfGYWBcdg76wT
         Q2vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12258-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12258-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12258-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12258-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v2] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date: Thu, 08 Mar 2018 15:36:14 -0500
In-Reply-To: <20180308202347.31331-1-tycho@tycho.ws>
References: <20180308202347.31331-1-tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030820-0040-0000-0000-0000043C8CD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030820-0041-0000-0000-000020DFAE43
Message-Id: <1520541374.3605.101.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594402547592935810?=
X-GMAIL-MSGID: =?utf-8?q?1594403218643800610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 13:23 -0700, Tycho Andersen wrote:

>  /*
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2cfb0c714967..356faae6f09c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -288,8 +288,11 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>  					      xattr_value, xattr_len, opened);
>  		inode_unlock(inode);
>  	}
> -	if (action & IMA_AUDIT)
> -		ima_audit_measurement(iint, pathname);
> +	if (action & IMA_AUDIT) {
> +		rc = ima_audit_measurement(iint, pathname);
> +		if (rc < 0)
> +			goto out_locked;
> +	}
> 
>  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
>  		rc = 0;

Only when IMA-appraisal is enforcing file data integrity should
process_measurement() ever fail.  Other errors can be logged/audited.

Mimi
