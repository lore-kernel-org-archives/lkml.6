Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeCKWGx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:06:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932398AbeCKWGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:06:51 -0400
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jiandi An <anjiandi@codeaurora.org>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Sun, 11 Mar 2018 18:06:41 -0400
In-Reply-To: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031122-0016-0000-0000-000005300BF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031122-0017-0000-0000-0000286D3686
Message-Id: <1520806001.3547.10.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803110282
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 23:26 -0600, Jiandi An wrote:
> TPM_CRB driver is the TPM support for ARM64.  If it
> is built as module, TPM chip is registered after IMA
> init.  tpm_pcr_read() in IMA driver would fail and
> display the following message even though eventually
> there is TPM chip on the system:
> 
> ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> 
> Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
> built in kernel and initializes before IMA driver.
> 
> Signed-off-by: Jiandi An <anjiandi@codeaurora.org>

Thanks, this patch has been applied.

Mimi

> ---
>  security/integrity/ima/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 35ef693..6a8f677 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -10,6 +10,7 @@ config IMA
>  	select CRYPTO_HASH_INFO
>  	select TCG_TPM if HAS_IOMEM && !UML
>  	select TCG_TIS if TCG_TPM && X86
> +	select TCG_CRB if TCG_TPM && ACPI
>  	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
>  	help
>  	  The Trusted Computing Group(TCG) runtime Integrity
