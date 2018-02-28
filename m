Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeB1MJr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:09:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752223AbeB1MJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:09:43 -0500
Date: Wed, 28 Feb 2018 04:09:29 -0800
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, oleg@redhat.com
Subject: Re: [RFC 1/4] Uprobe: Rename map_info to uprobe_map_info
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228075345.674-2-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180228075345.674-2-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18022812-0040-0000-0000-00000438CB6A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022812-0041-0000-0000-000020DAFC9C
Message-Id: <20180228120929.GB63063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> -static inline struct map_info *free_map_info(struct map_info *info)
> +static inline struct uprobe_map_info *
> +free_uprobe_map_info(struct uprobe_map_info *info)
>  {
> -	struct map_info *next = info->next;
> +	struct uprobe_map_info *next = info->next;
>  	kfree(info);
>  	return next;
>  }
> 
> -static struct map_info *
> -build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
> +static struct uprobe_map_info *
> +build_uprobe_map_info(struct address_space *mapping, loff_t offset,
> +		      bool is_register)

Imho, uprobe_build_map_info may be better than build_uprobe_map_info,
similarly uprobe_free_map_info.
