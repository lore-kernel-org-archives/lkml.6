Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-248046-1527086577-2-10482368483227518336
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527086577; b=QsvWZeF3fCeEeFDhrC71ush9yJATEFbDod01M1ECW4Ot/Rx71V
    RCNqrWEHHwrSPWIePr+sBLzMm4vuL0Mp+sMQKFVNNW51V8ZGjlsIsnEYtfMge6EU
    kL1is4SAv9m+gSZYDcT133uA+Y0y0GRvBnPKao65MzjyXAZUFheM5W1neiHax7mt
    rykkvbVUPFBPD2eEwBgK6QWj4zesfxHfAiV0QXoA1KTnkuSEyD9/eFakbA0L/EjA
    pVBRPWBzU0WHfL/8p2e89MokdtEipk7lqtLj4lwfwKUI8WCeegWnii47yMm4EgDt
    6NkpkorM+oYNoKqoxtE7gt6TsiE9xHLAEcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527086577; bh=1v+JYcjRv/xS
    yMVZDGlb8Amdbv98K4nbn9gXSLw8s10=; b=OIwyqeUcjYUgcDFDGjn/+hCBkwjv
    Ur+Paqv5rcAnJ1CnPXXmSeVnerzgbjGySj2bqy0v4vreGS7F/NFZEIHUKYaOMYJC
    Vr+sNL6wjWMWPP/VN/jskZd0p5spgG9dnY/t1OMxSVNbNofhZTuNRdkUtmUFZPrn
    d6eto2ntAYC7eSmhx4H/Wj/6Zz/sNh7pGODTQioHsgEb92yVchsD0FN7zgX4pp3i
    NFdI7ez+jvW+Bw7Zcc/rHgvsN7KHX9crOocJVYbHJ5tv+EpuEW/MBXd234cbwuGF
    7xW+0GNmJYRLrtqjYmKh7CHybhdxc5qnQjndfRVronce9HK2BXqpO9/DUA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH12LH2Z38yZtO+Bnld4kds7zydhWmW43lhC8+SILSGu4EHbbR/a5E+O70bKRZy5ozbyjUhX03CTRcf0knEjOqQrZ5Usfgg7Y3gyFlo2LVErEoyXgd8O
    nHf+M5NzS6cF+HZPqUtkH4uRIUiOsKGp7tHY3w79gjVmeQYeYOR4Hptixmu2ufSQYEhKPkiyKjqKF46H68tKMT2rsWqjKLYh7YVmcC+0PJIU8U8bZLq3TWFM
    k/eLIi/YRLQyV9gLgxQ/qg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=K6HrmWtEAAAA:8 a=hBqU3vQJAAAA:8
    a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=B218esqBk1pxTWaAb8YA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=yV38gEssg_2GhkhKF82i:22 a=WLjMIN4s_96MqnBbPenP:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933149AbeEWOmx (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 10:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36535 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933231AbeEWOmv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 May 2018 10:42:51 -0400
Subject: Re: [PATCH 25/33] ima: use match_string() helper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Wed, 23 May 2018 10:42:43 -0400
In-Reply-To: <1526903890-35761-26-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
         <1526903890-35761-26-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052314-0012-0000-0000-000005D9CD31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052314-0013-0000-0000-00001957182F
Message-Id: <1527086563.4168.0.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230149
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-21 at 19:58 +0800, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  security/integrity/ima/ima_main.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 74d0bd7..f807093 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -61,14 +61,11 @@ static int __init hash_setup(char *str)
>  		goto out;
>  	}
> 
> -	for (i = 0; i < HASH_ALGO__LAST; i++) {
> -		if (strcmp(str, hash_algo_name[i]) == 0) {
> -			ima_hash_algo = i;
> -			break;
> -		}
> -	}
> -	if (i == HASH_ALGO__LAST)
> +	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
> +	if (i < 0)
>  		return 1;
> +
> +	ima_hash_algo = i;
>  out:
>  	hash_setup_done = 1;
>  	return 1;

