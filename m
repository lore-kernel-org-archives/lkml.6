Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8103C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6720831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F6720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbeKTAq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:46:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728258AbeKTAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:46:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAJEIuDr149614
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:23:10 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nuwtcuf9r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:23:09 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Mon, 19 Nov 2018 14:23:09 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Nov 2018 14:23:05 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAJEN4mo18874576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 14:23:05 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDC4EC6057;
        Mon, 19 Nov 2018 14:23:04 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2EBCC6055;
        Mon, 19 Nov 2018 14:23:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Nov 2018 14:23:03 +0000 (GMT)
Subject: Re: [PATCH v9 00/17] Removed nested TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 19 Nov 2018 09:23:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18111914-0036-0000-0000-00000A5D485A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010080; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01119727; UDB=6.00580971; IPR=6.00899849;
 MB=3.00024231; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-19 14:23:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111914-0037-0000-0000-000049AFA401
Message-Id: <1393743e-7c54-4a83-ba2a-779a3a8a31e3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/18 7:47 AM, Jarkko Sakkinen wrote:
> [was Detach TPM space code out of the tpm_transmit() flow but the scope
>   expanded a bit.]
>
> Make the changes necessary to detach TPM space code and TPM activation
> code out of the tpm_transmit() flow because of both of these can cause
> nested tpm_transmit() calls. The nesteds calls make the whole flow hard
> to maintain, and thus, it is better to just fix things now before this
> turns into a bigger mess.

Tested this series with the vtpm proxy test cases:


Tested-by: Stefan Berger <stefanb@linux.ibm.com>


>
> v9:
> * Fixed again tpm_try_get_ops().
> * Added missing reviewed-by's.
>
> v8:
> * Re-add the check for ret < 0 after calling tpm_try_transmit() that
>    was dropped by mistake while moving code.
> * Fix error fallback for tpm_try_get_ops() when tpm_chip_start()
>    fails.
>
> v7:
> *  Reorganize series so that more trivial and self-contained changes are
>     in the head.
>
> v6:
> * When tpm_validate_commmand() was moved to tpm2-space.c, the struct for
>    the TPM header was incorrectly declared as struct tpm_input_header.
> * Fix return value in tpm_validate_command().
>
> v5:
> * Add the missing rev's from Stefan Berger.
>
> v4:
> * Return 0 from pcrs_show() when tpm1_pcr_read() fails.
> * Fix error handling flow in tpm_try_transmit().
> * Replace struct tpm_input_header and struct tpm_output_header with
>    struct tpm_header.
>
> v3:
> * Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
> * Move TPM power gating code and locking to tpm_try_get_ops() and
>    tpm_put_ops().
> * Call power gating code directly in tpm_chip_register() and
>    tpm2_del_space().
>
> v2:
> * Print tpm2_commit_space() error inside tpm2_commit_space()
> * Error code was not printed when recv() callback failed. It is
>    fixed in this version.
> * Added a patch that removes @space from tpm_transmit().
> * Fixed a regression in earlier series. Forgot to amend the change
>    from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.
>
> Jarkko Sakkinen (17):
>    tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
>    tpm: fix invalid return value in pubek_show()
>    tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
>    tpm: print tpm2_commit_space() error inside tpm2_commit_space()
>    tpm: declare struct tpm_header
>    tpm: access command header through struct in tpm_try_transmit()
>    tpm: encapsulate tpm_dev_transmit()
>    tpm: call tpm2_flush_space() on error in tpm_try_transmit()
>    tpm: clean up tpm_try_transmit() error handling flow
>    tpm: move tpm_validate_commmand() to tpm2-space.c
>    tpm: move TPM space code out of tpm_transmit()
>    tpm: remove @space from tpm_transmit()
>    tpm: use tpm_try_get_ops() in tpm-sysfs.c.
>    tpm: remove TPM_TRANSMIT_UNLOCKED flag
>    tpm: introduce tpm_chip_start() and tpm_chip_stop()
>    tpm: take TPM chip power gating out of tpm_transmit()
>    tpm: remove @flags from tpm_transmit()
>
>   drivers/char/tpm/tpm-chip.c       | 109 ++++++++++++
>   drivers/char/tpm/tpm-dev-common.c |  45 ++++-
>   drivers/char/tpm/tpm-interface.c  | 264 ++++++------------------------
>   drivers/char/tpm/tpm-sysfs.c      | 138 ++++++++++------
>   drivers/char/tpm/tpm.h            |  64 +++-----
>   drivers/char/tpm/tpm1-cmd.c       |  28 +---
>   drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
>   drivers/char/tpm/tpm2-space.c     |  93 ++++++++---
>   drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
>   drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
>   drivers/char/tpm/xen-tpmfront.c   |   2 +-
>   11 files changed, 410 insertions(+), 422 deletions(-)
>

