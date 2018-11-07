Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19276C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD29620862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD29620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbeKHCRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:17:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727546AbeKHCRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:17:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7GeDDj110228
        for <linux-kernel@vger.kernel.org>; Wed, 7 Nov 2018 11:45:56 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nm0ty8sgd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:45:55 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 7 Nov 2018 16:45:52 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 16:45:50 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA7GjnR962324776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 16:45:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35A30AE055;
        Wed,  7 Nov 2018 16:45:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3933AE04D;
        Wed,  7 Nov 2018 16:45:48 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Nov 2018 16:45:48 +0000 (GMT)
Date:   Wed, 7 Nov 2018 18:45:47 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: extend $type_param to match members
 referenced by pointer
References: <1541602808-26233-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541602808-26233-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18110716-0016-0000-0000-00000222AD7D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110716-0017-0000-0000-0000327AFD5B
Message-Id: <20181107164546.GC5638@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 05:00:08PM +0200, Mike Rapoport wrote:
> Currently, function parameter description can match '@type.member'
> expressions but fails to match '@type->member'.
> Extend the $type_param regex to allow matching both
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---

It seems I've really screwed up with the whitespace here :(
v2 is on the way, sorry for the noise.

>  scripts/kernel-doc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index ffbe901..3ce8800 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -212,7 +212,7 @@ my $anon_struct_union = 0;
>  my $type_constant = '\b``([^\`]+)``\b';
>  my $type_constant2 = '\%([-_\w]+)';
>  my $type_func = '(\w+)\(\)';
> -my $type_param = '\@(\w*(\.\w+)*(\.\.\.)?)';
> +my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>  my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
>  my $type_env = '(\$\w+)';
>  my $type_enum = '\&(enum\s*([_\w]+))';
> @@ -361,7 +361,7 @@ my $doc_com = '\s*\*\s*';
>  my $doc_com_body = '\s*\* ?';
>  my $doc_decl = $doc_com . '(\w+)';
>  # @params and a strictly limited set of supported section names
> -my $doc_sect = $doc_com . 
> +my $doc_sect = $doc_com .
>      '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:(.*)';
>  my $doc_content = $doc_com_body . '(.*)';
>  my $doc_block = $doc_com . 'DOC:\s*(.*)?';
> @@ -751,7 +751,7 @@ sub output_blockhead_rst(%) {
>  
>  #
>  # Apply the RST highlights to a sub-block of text.
> -#   
> +#  
>  sub highlight_block($) {
>      # The dohighlight kludge requires the text be called $contents
>      my $contents = shift;
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

