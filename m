Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755510AbeEaPDB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:03:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755163AbeEaPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:02:59 -0400
Subject: Re: [PATCH v2 13/21] ima: use match_string() helper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: andy.shevchenko@gmail.com, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Thu, 31 May 2018 11:02:38 -0400
In-Reply-To: <1527765086-19873-14-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
         <1527765086-19873-14-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18053115-0008-0000-0000-000002426993
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053115-0009-0000-0000-000021A81751
Message-Id: <1527778958.3427.16.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 19:11 +0800, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
> 
> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

In the future, the patch's author Signed-off-by is always first.

Thanks, this patch is now queued in the next-integrity branch.

Mimi

> ---
> v2:
>  - add Reviewed-by tag.
> 
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
