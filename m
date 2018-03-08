Return-Path: <kernel-hardening-return-12271-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuX2Dr/8/7hgVFJfoP7YgBNJc1KfnDk6VWqn8vR2fzaOq2HahPS9hk6X+9/PLp+pqjCKiqu
ARC-Seal: i=1; a=rsa-sha256; t=1520546768; cv=none;
        d=google.com; s=arc-20160816;
        b=XgVDOBlHYf/6mE2rhkdesIKopRQQ2Z05+fSxKkQARHCsCWoCLOGTWr/eBzqnXC8KOJ
         PtVVuo9g/lTU5YHCmEBvwD9eDRkQJopONtyDF8yVYZ7J0bAumq8CPerWtcwi8zVwWBM5
         H6tcwcCQ8d0wpDkI8ZeuBkRUq7xcuhRLOARd9gQV9YxUpyRhRtmVpuid7M+0lvjbuscf
         jf11nqU+hcbN7QY8zvx/lRGIMQdJBnV/N/imo7eL3BYDmecRUPY0pibrfDscNCZGJxoI
         3Ejgxjkd8YCU/8yrprs4IQP4elWjfKvD5DX2s1TIACms9gDslDtr82qQbPiJteoeeC4p
         QQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=0pmi/6qplyz+YN9YZt0W2hXOgJeRqTc1BlxN7FbBgTg=;
        b=Q8FxEQgLpYDK+vOdo/yCY5x/pWFyo48lzT7RWJa93l3DEa3ire6rzkYjH1T3anzZj4
         YEbi/jZVtvn9MzoABeiaDfWOYlLl1AbOERtZxclX0wp7YBQy1DKOsQFh4+r5Y9RIjfa4
         8HSLv/DwCTXZuLXPcu6xzxy0SaQ6PfhG/W/fhpvUyW/6tP52uKHudcfFx9Z5D9PjTC35
         jX/47dXBDmUuuWpzuvgfyv7xzKnIQheten4dRJ10fkTywszODKqMNpP/vDLpDRzQgcDo
         LWIZ4TwxNBtaope6PCBEkDYz39B9hUzaB4apWMCUWjVpjXBMKfWQolRlDjxCf+Fb1LM+
         4zhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12271-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12271-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12271-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12271-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v2] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date: Thu, 08 Mar 2018 17:05:40 -0500
In-Reply-To: <20180308214547.kdeoeozugxffzumn@smitten>
References: <20180308202347.31331-1-tycho@tycho.ws>
	 <1520541374.3605.101.camel@linux.vnet.ibm.com>
	 <20180308214547.kdeoeozugxffzumn@smitten>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030822-0040-0000-0000-0000041C98FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030822-0041-0000-0000-0000261FB5B3
Message-Id: <1520546740.3605.124.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080236
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594402547592935810?=
X-GMAIL-MSGID: =?utf-8?q?1594408847670521614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 14:45 -0700, Tycho Andersen wrote:
> Hi Mimi,
> 
> On Thu, Mar 08, 2018 at 03:36:14PM -0500, Mimi Zohar wrote:
> > On Thu, 2018-03-08 at 13:23 -0700, Tycho Andersen wrote:
> > 
> > >  /*
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > index 2cfb0c714967..356faae6f09c 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -288,8 +288,11 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> > >  					      xattr_value, xattr_len, opened);
> > >  		inode_unlock(inode);
> > >  	}
> > > -	if (action & IMA_AUDIT)
> > > -		ima_audit_measurement(iint, pathname);
> > > +	if (action & IMA_AUDIT) {
> > > +		rc = ima_audit_measurement(iint, pathname);
> > > +		if (rc < 0)
> > > +			goto out_locked;
> > > +	}
> > > 
> > >  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
> > >  		rc = 0;
> > 
> > Only when IMA-appraisal is enforcing file data integrity should
> > process_measurement() ever fail.  Other errors can be logged/audited.
> 
> Ok, so previously in ima_audit_measurement() when allocation failed,
> there was nothing logged. If we just keep this behavior like below,
> does that look good?

Before the IMA locking change that were just upstreamed, there were
problems with measuring/appraising files that were opened with the
O_DIRECT flag.  Unless the IMA policy specified permit_directio, the
measurement/appraisal failed.  With the new locking, opening files
with the O_DIRECTIO flag shouldn't be a problem.  It just needs to be
fully tested before removing this code.

On failure, the code below tests the ima_audit_measurement() result
and skips the IMA_PERMIT_DIRECTIO test.  Unless I'm missing something,
I don't see the point.

Mimi


> Thanks!
> 
> Tycho
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 356faae6f09c..4e699bc7adc5 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -289,9 +289,13 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>  		inode_unlock(inode);
>  	}
>  	if (action & IMA_AUDIT) {
> -		rc = ima_audit_measurement(iint, pathname);
> -		if (rc < 0)
> +		int ret;
> +
> +		ret = ima_audit_measurement(iint, pathname);
> +		if (ret < 0 && ima_appraise & IMA_APPRAISE_ENFORCE) {
> +			rc = ret;
>  			goto out_locked;
> +		}
>  	}
> 
>  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
> 
