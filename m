Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939216AbeE1OAH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:00:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937454AbeE1OAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:00:03 -0400
Subject: Re: [PATCH 4.14 199/496] scsi: core: return BLK_STS_OK for DID_OK in
 __scsi_error_from_host_byte()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>
Cc: stable@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180528100319.498712256@linuxfoundation.org>
 <20180528100328.325324152@linuxfoundation.org>
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 28 May 2018 15:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180528100328.325324152@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052813-0040-0000-0000-0000045E371D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052813-0041-0000-0000-00002102A40B
Message-Id: <ebdbc325-6f1c-ceab-97f8-d57194367440@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280170
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

question:
drop because of upstream's

cbe095e2b584 ("Revert "scsi: core: return BLK_STS_OK for DID_OK in 
__scsi_error_from_host_byte()"")
Fixes: e39a97353e53 ("scsi: core: return BLK_STS_OK for DID_OK in
__scsi_error_from_host_byte()")

as in stable-queue's

c40541008b93 ("drop a scsi patch from 4.14")

?

On 05/28/2018 11:59 AM, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Hannes Reinecke <hare@suse.de>
> 
> [ Upstream commit e39a97353e5378eb46bf01679799c5704d397f32 ]
> 
> When converting __scsi_error_from_host_byte() to BLK_STS error codes the
> case DID_OK was forgotten, resulting in it always returning an error.
> 
> Fixes: 2a842acab109 ("block: introduce new block status code type")
> Cc: Doug Gilbert <dgilbert@interlog.com>
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/scsi/scsi_lib.c |    2 ++
>   1 file changed, 2 insertions(+)
> 
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -720,6 +720,8 @@ static blk_status_t __scsi_error_from_ho
>   		int result)
>   {
>   	switch (host_byte(result)) {
> +	case DID_OK:
> +		return BLK_STS_OK;
>   	case DID_TRANSPORT_FAILFAST:
>   		return BLK_STS_TRANSPORT;
>   	case DID_TARGET_FAILURE:
> 
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
