Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804FEC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5360920862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5360920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbeKGAeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:34:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730448AbeKGAeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:34:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6F4lq3029403
        for <linux-kernel@vger.kernel.org>; Tue, 6 Nov 2018 10:08:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nkbudcsh2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 10:08:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 6 Nov 2018 15:08:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Nov 2018 15:08:19 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA6F8InQ5243278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 15:08:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 221BC52052;
        Tue,  6 Nov 2018 15:08:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.87.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8D5BD52050;
        Tue,  6 Nov 2018 15:08:16 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] keys: export find_keyring_by_name()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>, dhowells@redhat.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jforbes@redhat.com, seth.forshee@canonical.com, pjones@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>
Date:   Tue, 06 Nov 2018 10:08:05 -0500
In-Reply-To: <20180309153803.25859-2-nayna@linux.vnet.ibm.com>
References: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
         <20180309153803.25859-2-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110615-0012-0000-0000-000002C49453
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110615-0013-0000-0000-000020F8D98A
Message-Id: <1541516885.8568.29.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nayna,

On Fri, 2018-03-09 at 21:08 +0530, Nayna Jain wrote:
> This patch exports the function find_keyring_by_name() to be used by
> other subsystems.

Looking this patch over again, I realize that exported functions must
be prefixed with the subsystem name.  I'm also a bit concerned with
exporting find_keyring_by_name().  David, any comments?

Perhaps it would be better if IMA creates the .platform keyring so
that it has access to the keyring id instead.

Mimi
  
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2:
> * Fix the patch description per line length as suggested by Mimi
> 
>  include/linux/key.h      | 2 ++
>  security/keys/internal.h | 2 --
>  security/keys/keyring.c  | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index e58ee10f6e58..c8d332d4103c 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -346,6 +346,8 @@ static inline key_serial_t key_serial(const struct key *key)
> 
>  extern void key_set_timeout(struct key *, unsigned);
> 
> +extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
> +
>  /*
>   * The permissions required on a key that we're looking up.
>   */
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 9f8208dc0e55..8aa8d347a1ab 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -141,8 +141,6 @@ extern key_ref_t keyring_search_aux(key_ref_t keyring_ref,
>  extern key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx);
>  extern key_ref_t search_process_keyrings(struct keyring_search_context *ctx);
> 
> -extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
> -
>  extern int install_user_keyrings(void);
>  extern int install_thread_keyring_to_cred(struct cred *);
>  extern int install_process_keyring_to_cred(struct cred *);
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 41bcf57e96f2..4b9c3f1166d1 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1152,6 +1152,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  	read_unlock(&keyring_name_lock);
>  	return keyring;
>  }
> +EXPORT_SYMBOL(find_keyring_by_name);
> 
>  static int keyring_detect_cycle_iterator(const void *object,
>  					 void *iterator_data)

