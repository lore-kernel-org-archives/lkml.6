Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeCMSQw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:16:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751362AbeCMSQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:16:51 -0400
Subject: Re: [RFC PATCH linux-next] evm: evm_hmac can be static
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: kbuild test robot <fengguang.wu@intel.com>,
        =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: kbuild-all@01.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 14:16:42 -0400
In-Reply-To: <20180313174224.GA28779@intel17>
References: <201803140150.bfjQDiL5%fengguang.wu@intel.com>
         <20180313174224.GA28779@intel17>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031318-0020-0000-0000-000004040460
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031318-0021-0000-0000-00004298045E
Message-Id: <1520965002.3547.342.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-14 at 01:42 +0800, kbuild test robot wrote:
> Fixes: c49fc264be98 ("evm: Move evm_hmac and evm_hash from evm_main.c to evm_crypto.c")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Thanks!

> ---
>  evm_crypto.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index fdde9cb..a46fba3 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -37,8 +37,8 @@ static DEFINE_MUTEX(mutex);
> 
>  static unsigned long evm_set_key_flags;
> 
> -char * const evm_hmac = "hmac(sha1)";
> -char * const evm_hash = "sha1";
> +static char * const evm_hmac = "hmac(sha1)";
> +static char * const evm_hash = "sha1";
> 
>  /**
>   * evm_set_key() - set EVM HMAC key from the kernel
