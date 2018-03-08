Return-Path: <kernel-hardening-return-12250-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvET3Yno0ndRc+NZuhoTgKJ3HQSs/lt0my66aJDILDmL4D1DUyYWnyKoFDb638YEkSuLIg2
ARC-Seal: i=1; a=rsa-sha256; t=1520535055; cv=none;
        d=google.com; s=arc-20160816;
        b=WTPR0CtXJtFLz3E64j2bJkFXWvlAGpy/4I9mvyFpOpz3m+ScnJqnc6+bmzxj+SttHI
         DbfnLYzvZ6gqBurbvhLS2BD1t7YlxPW4VFgTaO52L+IzuTlMbkWa34UTHCKsklmhH63r
         CLJNU/dNj1zrK4vZs1EfHubT43svlaYbd5FenhfdxqlfS85lKQTskSBUFaQqskL9Xx9X
         u+FCkt4f4GowPeBY0n5aJyD+33MNq8NP32I8V6g58Nn2W11zuqxOxOIdVUZ+vz34Vf/8
         i+ipvfWJzsMfKTQKVkXNDrkLq81QC6GabfJImpydvwC8MoqLiqc02Qhk9BNDgLq8BXmR
         4WGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=9uO5GLJNYjpEFBzpkawgWF+tiKSnjkVv5HSfjsle+Ws=;
        b=0W8Q3PP5j4v34RCr97YJhrXkjWMBmBx9PorwYsvrcRrftNuVSj29oInbfDV1reZ9It
         FtCuwX8DFcCzDAe9Cxi834fq0ovkMYob2bAbrAjufktb6eP6fMZTJEjUQVuK0gye4nj5
         BqP+EtaSZKmuK5c0M0EN6D4Ko9OcIJzt9eRw7eiBbs29jUTC/j4U594EgGzMige4qvFi
         TfHRxwv+MGDFTVUnvKlMp50z9wWUytI4TQdIN07srl8ZTnOj41SWe64bNpDfSWT2Qb3Y
         aDDlCGfvDnodgpLhTXILdb3cSP4482SwIKoZQuutauvVzfEXYp68M/RANfl2h8pYakaG
         pObw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12250-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12250-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12250-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12250-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>,
        Andy Shevchenko
 <andy.shevchenko@gmail.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com
Date: Thu, 08 Mar 2018 13:50:30 -0500
In-Reply-To: <20180308183721.mnsrmhekyfo2dbso@smitten>
References: <20180308171456.2597-1-tycho@tycho.ws>
	 <CAHp75VfoiQ_PxBph8JnNzun4y5Z-9z_rUcjGyM7A2CAwynddeA@mail.gmail.com>
	 <20180308183721.mnsrmhekyfo2dbso@smitten>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030818-0040-0000-0000-0000041C89F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030818-0041-0000-0000-0000261FA63C
Message-Id: <1520535030.3605.64.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080212
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594389722092015419?=
X-GMAIL-MSGID: =?utf-8?q?1594396565718792822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 11:37 -0700, Tycho Andersen wrote:
> On Thu, Mar 08, 2018 at 07:47:37PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 8, 2018 at 7:14 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > > In keeping with the directive to get rid of VLAs [1], let's drop the VLA
> > > from ima_audit_measurement(). We need to adjust the return type of
> > > ima_audit_measurement, because now this function can fail if an allocation
> > > fails.
> > 
> > 
> > 
> > > +       algo_hash_len = hash_len + strlen(algo_name) + 2;
> > > +       algo_hash = kzalloc(algo_hash_len, GFP_KERNEL);
> > 
> > > -       snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
> > > +       snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> > 
> > kasprintf() ?
> 
> Sure, in fact I think we could just do:
> 
> -	snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> -	audit_log_untrustedstring(ab, algo_hash);
> +	audit_log_untrustedstring(ab, algo_name);
> +	audit_log_format(ab, ":");
> +	audit_log_untrustedstring(ab, hash);
> 
> and get rid of the allocation entirely. I'll test and make sure it
> works and then re-send.

The hash algorithm name is an enumeration that comes from the kernel.
 It's defined in crypto/hash_info.c: hash_algo_name.  Why do we need
to use audit_log_untrustedstring()?

Mimi
