Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527164384-2-2655747565221999225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164384; b=cxBPgontVW9LOSu6x/sT9oGtRKorUG+c0egGQ3eNt5AiE/8uG+
    vo8BvTymGf+Ie9S8nNOFGB5DFmaTk5PEVR5PoGV9IgD88Vz25nAFP+FCDqkkhEvQ
    GqD6pKPwcyIOlayHrnHQJ5HaBPDGu3HwO0mcFzCDTWfSivQzib1g8XK2baNJsdUX
    +2UIFF7koTDWZHGNLey3RrtKuLJJEqTSAFtQKZUreomB34w41YcxkaETzRjMixlS
    SiFypYjTF+w0vqoKkp3WApojj9gts1+/rbzc+prknkUzqXmXqdVYqOClUhSNBy7k
    NBP5mtfK0OYY9bsbVOv0euRexQko2EerCB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527164384; bh=Hrim0uu89BOp
    TrZXc4em751xhHcHoSalidKvxT2TQZU=; b=ZWIeyRm+Wc9rbGK/MWHHpyiUWplw
    OOnVDcN6pSSy9vs+C/ueL9XWfaOpjZM+Ia9nGTzaJlEdwxZYmVvaGAF4DZu0avqr
    OkZEPXoQNO5GgsFdNPIw5BAk8IUvtqqu8pVaxdyA7kEsVzqohmJsi1Xqb/JtSz3A
    T072RxeZuuQZJEdTJDbtG6JZ5TEAdUVnqsUOlkoMMQOMJQIQ/3taP0Ej70S8JIBn
    /GLfE0FtMjZHmOea7earss50yk5+p1yvyfhBQgjfZnCIkt1RnaNMHKXRCOKAByeX
    BpKyzqVesj2ZwvWs9bVHuYFgeN8VdbqNWckclD5D0wjWO5ixZf0fuCDqaQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJw+1ESItkVk5XAB3tY7utoXRUaO5/+PXsoI8+aonl9DIashuAth/XsXq6+Ej4TSJlvPLCZ0Dr5Nwdgb88kxm/Yyx8aFnKV2bMC2+iYSIL5FE/ShjCCv
    20foPgHGaYzKx1NArcpTC7yPjF3k0fwlOzQ7i+7uscGpLj+FeDAmCHWrrJ1vWLwi8ScNH/ywxlTHhyDC4RJDCQPLYMcukEmw5H+yguI+ADDmrzje0t0f4g6u
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JF9118EUAAAA:8 a=iox4zFpeAAAA:8 a=NCkSHYsgAAAA:8 a=VwQbUJbxAAAA:8
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=Lh2iM_emvY-ES8JQXb4A:9
    a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=AnMw66Xr5OuzjdxB04dI:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966236AbeEXMTl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:19:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S969756AbeEXMTh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 08:19:37 -0400
Subject: Re: [PATCH 4.14 110/165] scsi: core: return BLK_STS_OK for DID_OK in
 __scsi_error_from_host_byte()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Cc: stable@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180524093621.979359379@linuxfoundation.org>
 <20180524093626.469402002@linuxfoundation.org>
From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 24 May 2018 14:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524093626.469402002@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052412-0044-0000-0000-000005564100
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052412-0045-0000-0000-000028984420
Message-Id: <fdd36949-3a0c-0b7d-1946-34fd253569c5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240146
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hopefully I haven't missed it in the stable queue, but do we need the 
following on top (effectively not applying e39a97353e53)?:

commit cbe095e2b584623b882ebaf6c18e0b9077baa3f7
Author: Bart Van Assche <bart.vanassche@wdc.com>
Date:   Thu Apr 5 10:32:59 2018 -0700

     Revert "scsi: core: return BLK_STS_OK for DID_OK in 
__scsi_error_from_host_byte()"

     The description of commit e39a97353e53 is wrong: it mentions that 
commit
     2a842acab109 introduced a bug in __scsi_error_from_host_byte() 
although that
     commit did not change the behavior of that function.  Additionally, 
commit
     e39a97353e53 introduced a bug: it causes commands that fail with
     hostbyte=DID_OK and driverbyte=DRIVER_SENSE to be completed with
     BLK_STS_OK. Hence revert that commit.

     Fixes: e39a97353e53 ("scsi: core: return BLK_STS_OK for DID_OK in 
__scsi_error_from_host_byte()")
     Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
     Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
     Cc: Hannes Reinecke <hare@suse.com>
     Cc: Douglas Gilbert <dgilbert@interlog.com>
     Cc: Damien Le Moal <damien.lemoal@wdc.com>
     Cc: Christoph Hellwig <hch@lst.de>
     Cc: Lee Duncan <lduncan@suse.com>
     Cc: stable@vger.kernel.org
     Reviewed-by: Christoph Hellwig <hch@lst.de>
     Reviewed-by: Hannes Reinecke <hare@suse.com>
     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>


On 05/24/2018 11:38 AM, Greg Kroah-Hartman wrote:
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
