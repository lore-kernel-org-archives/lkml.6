Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeCUXTA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:19:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754050AbeCUXS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:18:57 -0400
Subject: Re: [PATCH v6 07/12] integrity: Select CONFIG_KEYS instead of
 depending on it
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Wed, 21 Mar 2018 19:18:47 -0400
In-Reply-To: <20180316203837.10174-8-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
         <20180316203837.10174-8-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032123-0012-0000-0000-000005C1ED3C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032123-0013-0000-0000-0000193E12F0
Message-Id: <1521674327.3848.221.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210264
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-16 at 17:38 -0300, Thiago Jung Bauermann wrote:
> This avoids a dependency cycle in CONFIG_IMA_APPRAISE_MODSIG (introduced by
> a later patch in this series): it will select CONFIG_MODULE_SIG_FORMAT
> which in turn selects CONFIG_KEYS. Kconfig then complains that
> CONFIG_INTEGRITY_SIGNATURE depends on CONFIG_KEYS.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  security/integrity/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index da9565891738..0d642e0317c7 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -17,8 +17,8 @@ if INTEGRITY
> 
>  config INTEGRITY_SIGNATURE
>  	bool "Digital signature verification using multiple keyrings"
> -	depends on KEYS
>  	default n
> +	select KEYS
>  	select SIGNATURE
>  	help
>  	  This option enables digital signature verification support
> 
