Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFCAC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3429A21BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3429A21BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeHIG7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 02:59:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbeHIG7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 02:59:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w794ZQYV113017
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 00:36:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kr99e22cv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 00:36:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 9 Aug 2018 05:36:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 05:36:00 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w794Zxf345416686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 04:35:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1175011C04A;
        Thu,  9 Aug 2018 07:36:06 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7B3A11C04C;
        Thu,  9 Aug 2018 07:36:05 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 07:36:05 +0100 (BST)
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org> <20180808155921.GB9543@kernel.org>
 <20180808160843.GC9543@kernel.org> <20180808161451.GD9543@kernel.org>
 <20180808164214.GE9543@kernel.org>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Thu, 9 Aug 2018 06:35:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180808164214.GE9543@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18080904-0012-0000-0000-000002973371
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080904-0013-0000-0000-000020CA40E0
Message-Id: <252202b1-bc08-a035-8de1-91136016d021@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 06:42 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 08, 2018 at 01:14:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Aug 08, 2018 at 01:08:43PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> No need for __packed.
>>  
>>> I'm removing that to avoid having this failling in compilers that have
>>> such a warning, since we default to Werror.
>>  
>>> Holler if there is something I'missing :-)
>>
>> In file included from util/cpumap.h:10,
>>                  from util/s390-cpumsf.c:150:
>> util/s390-cpumsf.c: In function 's390_cpumsf_diag_show':
>> util/s390-cpumsf.c:208:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>>    pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
>>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
>>  #define pr_fmt(fmt) fmt
>>                      ^~~
>> util/s390-cpumsf.c:208:3: note: in expansion of macro 'pr_err'
>>    pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
>>    ^~~~~~
>> util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':
>> util/s390-cpumsf.c:233:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>>    pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
> 
> So for those I applied this, seems to pass the ones that were failing,
> restarting tests...
> 
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> index 2bcb160a08f0..d2c78ffd9fee 100644
> --- a/tools/perf/util/s390-cpumsf.c
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -187,7 +187,7 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
>  		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
>  		return false;
>  	}
> -	color_fprintf(stdout, color, "    [%#08x] Basic   Def:%04x Inst:%#04x"
> +	color_fprintf(stdout, color, "    [%#08zx] Basic   Def:%04x Inst:%#04x"
>  		      " %c%c%c%c AS:%d ASN:%#04x IA:%#018llx\n"
>  		      "\t\tCL:%d HPP:%#018llx GPP:%#018llx\n",
>  		      pos, basic->def, basic->U,
> @@ -205,10 +205,10 @@ static bool s390_cpumsf_diag_show(const char *color, size_t pos,
>  				  struct hws_diag_entry *diag)
>  {
>  	if (diag->def < S390_CPUMSF_DIAG_DEF_FIRST) {
> -		pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
> +		pr_err("Invalid AUX trace diagnostic entry [%#08zx]\n", pos);
>  		return false;
>  	}
> -	color_fprintf(stdout, color, "    [%#08x] Diag    Def:%04x %c\n",
> +	color_fprintf(stdout, color, "    [%#08zx] Diag    Def:%04x %c\n",
>  		      pos, diag->def, diag->I ? 'I' : ' ');
>  	return true;
>  }
> @@ -230,10 +230,10 @@ static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
>  				     struct hws_trailer_entry *te)
>  {
>  	if (te->bsdes != sizeof(struct hws_basic_entry)) {
> -		pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
> +		pr_err("Invalid AUX trace trailer entry [%#08zx]\n", pos);
>  		return false;
>  	}
> -	color_fprintf(stdout, color, "    [%#08x] Trailer %c%c%c bsdes:%d"
> +	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
>  		      " dsdes:%d Overflow:%lld Time:%#llx\n"
>  		      "\t\tC:%d TOD:%#lx 1:%#llx 2:%#llx\n",
>  		      pos,
> @@ -418,7 +418,7 @@ static bool s390_cpumsf_make_event(size_t pos,
>  	event.sample.header.misc = sample.cpumode;
>  	event.sample.header.size = sizeof(struct perf_event_header);
>  
> -	pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
> +	pr_debug4("%s pos:%#zx ip:%#" PRIx64 " P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
>  		 __func__, pos, sample.ip, basic->P, basic->CL, sample.pid,
>  		 sample.tid, sample.cpumode, sample.cpu);
>  	if (perf_session__deliver_synth_event(sfq->sf->session, &event,
> @@ -498,7 +498,7 @@ static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
>  	 */
>  	aux_ts = get_trailer_time(buf);
>  	if (!aux_ts) {
> -		pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
> +		pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
>  		       sfq->buffer->data_offset);
>  		aux_ts = ~0ULL;
>  		goto out;
> @@ -607,7 +607,7 @@ static int s390_cpumsf_run_decoder(struct s390_cpumsf_queue *sfq,
>  		buffer->use_size = buffer->size;
>  		buffer->use_data = buffer->data;
>  	}
> -	pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
> +	pr_debug4("%s queue_nr:%d buffer:%" PRId64 " offset:%#" PRIx64 " size:%#zx rest:%#zx\n",
>  		  __func__, sfq->queue_nr, buffer->buffer_nr, buffer->offset,
>  		  buffer->size, buffer->use_size);
>  	err = s390_cpumsf_samples(sfq, ts);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I just updated the perf/core branch, compiled it and all works fine.

Thanks for fixing these errors.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

