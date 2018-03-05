Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935236AbeCENsI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:48:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934571AbeCENsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:48:03 -0500
Date: Mon, 5 Mar 2018 13:47:00 +0000
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH 2/3] mm: add indirectly reclaimable memory to MemAvailable
Message-ID: <20180305134655.GA13118@castle.DHCP.thefacebook.com>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180305133743.12746-3-guro@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:ec6d]
X-ClientProxiedBy: AM3PR07CA0133.eurprd07.prod.outlook.com
 (2603:10a6:207:8::19) To SN2PR15MB1087.namprd15.prod.outlook.com
 (2603:10b6:804:22::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c6ec546-3e32-433f-f7c3-08d5829f9956
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:SN2PR15MB1087;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;3:rBj6BkmcOCcJupmkshk8KYyyOSpgmeJL8GJlL2KdwreNnu8sPvg1pTdWEcuKVBC2sLwgkYos2n6YwezVeeWqa72K2mMW6vgOc6wFV67RS1qIuPmah4+WAKnjPKFTWvTOEbi+ixQ8oHnNAc07OLj2oMUJcJowGHV5h5IRfayQ6TQVbseOUW+QPQPkXqENnBnfS5NCWAQRAWctec8c23oZ03wzzJzLJ/EIlpY1+RfnOuKtvi7KqWuLKWVBOpu6hbWN;25:QLHNbomXGRyLJGK2t6FV2OAXjXDMX9t0OHUrxI2tmHR6oQvEjS1WwPDauLhr+H1GiVZyxjuoFR+VuW4RIHTh4//aXMnZtsiNsy+S7FxZfVnBR+bF+oEd7KwDIw9XrP2lO+LCIVpEodkwKXM3bzxmpMeMDsr2az0f6Kk6R0Ks049bt70tMMyA9i83b9/vCuAgRpUK0NBDTuOAG5OnKiaGjgzIJRiFGmSIOoesZ5Us+IkCN0nZXpUwWj0Q2QdK4rM1VTIAUdUqyKZNWe6xnieMymLC2s88xScCJYY94do2XvPtGZJoSeE6DnB/0fUL3gvYsLe7ZCLtfiC8+53PBfY08A==;31:HzvcR3nucaOt/lXmzNjsC5NqMVhVmkiEU0T/0w0hXBnNINs0Xvlp6Q3U9+/vzZLj/0CiPuvek+NoX+98hf89wIhcjfCIJteMxd+247oXEm6UEWi8i2eLiRHbfvX9Lc83DL8UEk5XsmwCaRdWi8Sv2iGK6rie3UwrGo3+0nEpRoknDdta/qy22l8qxvV+zbQ0xajlkbn//4LRo+Ho0XDaMUQOHyU0bdXIqh9c9emc19M=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1087:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:xW70fHEGixxeaGhaZpOgaWviDI1rUfrhsu9jMavC2Ukf7VmUPT1Tr3LTVyq+MsDdNxatNE7cwilrX2vvnKfiX2JLYL9wehgz0sW8E+KSh6xtvNgEHo1MIxtjcE9nav/tPeEGUWFd/IEzRnJIMoIgHVmrCjkT56bFHOWW0f1WS57IlmAcIVbazjhw3jXymRAdsVxCuGhTjYLCh6BATpjwpfZrMkBdfWSszKN5Mv6idAA4ryuxMPthhndDewJ0EfI5o6S6yu8QmS0qq3IDwIA1boSKGZ6LdcNjAUl0KWwNsv1xE+mJxC+Lmdi7s/rJqZfRkJdZtSeO+R/BlWIJ0w3PbLZgi6bXqNG0gtkbLTZlfPNjMDJJ5dEuFQrljrp0/RgmU6zDqYZOxekQVyuUZdOu3ksDD+wn6seo900j4LUX33EYCgNCYCGWFDbsGUVY5OPpSb+rpjniI/HgVJ3gD7Ko5aFQ7FDipjSakrb9xydu6uNZbX2OMgBdAqXKzfKLDCma;4:qVMw69tbR+8Okgv2Vbt3Lc+trdGKMZpYGsv4Zsducp46EPJzXCFWKBAdHEIsk3+mdv4Ljceqz/kQ69AUOiYnLBgMz0nZXlNeCYqTkmI1KLFMpZen8AZ/bVrR3cddeWRdLK7i8Zqd7AGtlAWkIvPgRKUqvDx2RHoia0LWK6vaTORZYkApRj0RarxFLaZEZ8yxiUNxwA+2ywzyqqzslRvo5FSuwdFAgelEdHL9d6/EtAQWDZLKlhIAzijzcNuyOY/SxZu8MG4Eq8FJrrEhD35K7e5fYjmftwCx8Pu5znl0JCBMqb6QBggUl3Vw03JzGk1dulddo49+vDlsnSYj4nChQg2P/OuOalFNxzaqX/rHTlU=
X-Microsoft-Antispam-PRVS: <SN2PR15MB108706E7D93681861EB1302ABEDA0@SN2PR15MB1087.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(11241501184)(944501244)(52105095)(3002001)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR15MB1087;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1087;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39380400002)(39860400002)(189003)(199004)(25786009)(105586002)(97736004)(52396003)(86362001)(386003)(6506007)(76176011)(68736007)(52116002)(5660300001)(7696005)(6116002)(50466002)(23726003)(1076002)(47776003)(8936002)(54906003)(16526019)(229853002)(316002)(186003)(55016002)(4326008)(16586007)(58126008)(6666003)(6246003)(33656002)(81156014)(81166006)(2906002)(46003)(53936002)(6916009)(2950100002)(8676002)(7736002)(9686003)(106356001)(2351001)(2361001)(305945005)(478600001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1087;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1087;23:Xqp8GYAfFP/qwtsaDmCvspC+Wv4c0f88l+SaJmVzK?=
 =?us-ascii?Q?MEUeVk92X05iPm9Tc+NpaNCX8gogmSSLgAr03PKGsCU3bekejUZhpFs8zYGw?=
 =?us-ascii?Q?TlM1JJH/DnqyFA7xePbXUXF6MdCMMpy5OW8Ib4iwKMWXQxOU7YfUN9W8qNNH?=
 =?us-ascii?Q?Hx1+hy6VX2Te/78eeuTpeA1XBsQI/fQXmtyamX+S635RE52k6gMaWQLYhbVG?=
 =?us-ascii?Q?uuBtkvHCEh/Is3jMdKc0M7xug+6WPpgKGRLbMrwupfvQ+6SnOBaFjAPVUsrU?=
 =?us-ascii?Q?UX8lcxHVcOBoRdIllmF514sOi80A6+4ybyWfWtq40wvLL9By+GIJXu3QcNHM?=
 =?us-ascii?Q?0vACTX5C+hUxX/OpbkO8RXQ44JCrIko03JhuaYCR/l9jrqYfFOhmYUrdUeQb?=
 =?us-ascii?Q?+v6KNthJKvfP2cttYJvDRCVXWX3zcGzi0lrmBpXCyJ4nZhTuI2l2ibnQpbfB?=
 =?us-ascii?Q?ORLVBMV7mimgszP1THJyFiZuGPFxLq8ELo2fCoftOlBNzJYEBD9+mKCVO+KB?=
 =?us-ascii?Q?uTp0q6+WPWYdUejg38VhE0A57CQFvvloiIESoRL6JdwmyzLLX5F5TVcFKf8L?=
 =?us-ascii?Q?kdCED6b+dNr3dPi8+uSWwxZYMCWJAL59cKOR4xinr87/6G/ArC/1Fsl9fu5N?=
 =?us-ascii?Q?lwQ4iIXVJywbyRBMja7XsKYUZR36ls6VzM8ISKYyG7IQL/HUrERYUDMYFaFm?=
 =?us-ascii?Q?lgG/uev8BFG+DygmEfbityOoAb1MlWWMKlf29UQ2o3VLjEoRVBwI+661+WCJ?=
 =?us-ascii?Q?RULq6yb6D0J0jSYKmGmjvauhaVkH6v47g5+tZd/E8yq0T12Jn0atUyC/wK41?=
 =?us-ascii?Q?eq0s4VkAarue9veFCAo5l6hmeuES87uZzgnsc4U3DJ4MvSuP3APo6Fwx+IK0?=
 =?us-ascii?Q?GW10ez30QRG7yeAIfmCL8Sjc61ILzZh6voYUN3usUk23nPJIg10GAmMaXvfR?=
 =?us-ascii?Q?E4UWvnh5Sa7V3qg7lBOFxlRhfn9gl1EQjjRHJ8v6K/4wBGEimN+PkS//LeC3?=
 =?us-ascii?Q?Vkpk15jrGebv2dLvEL03kXo+sLLomLLLvrlEdpb9sFu73oUI4gvV6FBroIDw?=
 =?us-ascii?Q?HxgYBWIEMcYrs7ECIry3SxWGKNcEV0ZmsVJKi+yA77EqmH5/kiiA1zC0LS+y?=
 =?us-ascii?Q?iMN68ptJ1oflkX8T+GDUHVFFuJlLSox30fUDpk5cPC4wYM/jftgN5FkDleEw?=
 =?us-ascii?Q?CPq278UKOE21/tYDCvOF1DY1bFJnByC6Gf3qwhEbkQHxuSfAD3PZfZMYKWsb?=
 =?us-ascii?Q?2haHEHc7TKATxiNmV4=3D?=
X-Microsoft-Antispam-Message-Info: m5iV1NIkBlB28Hq4X7XbZIVjW+k8ZTU0XgeSt6s+YYgoEBaxnXwXQVDX+Y/lLeA/v9wBQk08+xm25yMNPvRk7zvfzlX2oPtE7MFO0xZFDtlugb2izUolF/TwNZ/Na+UWovPCv/ae6WaE5VqtSQWT4HluKy04AjE+k4bzaaOLlPW5qpiXi9V27Hrrn0/DYmKU
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;6:PBLgGYJu+UQ2jV/6w+Kg8+lwQCr1sgEdywKuRFO14gh7+wxGcGUPM9FUHY7E+G9qKZn5+0t0UG14jdPMD/XjE2A2GXdH/QRJpSm+wxyIe1SKEeH9M4X5wAX4Dos+kJcBC4JB64sGWtm162niwaQ9PeB9EjutFlWMQWLPhltvDsQtILhevkLY90fGzQz0Iv32jcMfFL17o45JVSdT6fNSdhUV8FhFjlbuQwCL+3FeL6Lvwq8ohXoSFj/tmFwUQdrI7bPqDMGYa0cBXBGKZZKgIpFyS9ibZnTEE1wbuacbWN0SwwuBVpfHOEQ9rWX7E+na4IubfplV/0rhEF8FitpNAXSq+gnlXEhf3l0evVxd9tM=;5:cFBLqQ8wkCPu4MDf8C2DI9oLYyUR2MubWRxZuxdQhEHE1l3q5VEG8gDhbEpc6cMgrDY3ZAGN1G5K3UXfqONeZaZITIfxgfnbnSxml1x3gQlzONu6r8azorHhKwiWkiejwkDxcVqCm11TNMSHhIOF4CYcxU6yEBEQkPnqNP0uuJ0=;24:BK4P3Y0ZJcMQXljhfVP/MRAUGgQmmzAJLzutcy4Gn0qiYVF7lkl1UogqngaB21GN+TfT+UHBY2Wk9mi9Qh8qdUwgvfrE4BrVBsgjnfFOyPk=;7:T2sASc8HW64gNnTAhVio9cSOBFx4GGxCGKamQuECFNSlP0Nq+SNZstyPVv+ldHltQNJ9nLIadN3cZypoaGOuOiOc6gLhQrYJI3F+pcHUJ77W7U2PZkhGpFlha1YZ7ESF9AdWyQWaMDiFoWgwYNN2ENGxMxUdNfvOT8ABfnnk7UnQpbd3KxPj5rfrFafZ6k2EOpnH1lGFDUyA+OkjaCPRzEXnqeRnmxXEiR/JWuvoTiAi8bLEWPATEi/pZGA73Nls
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:5vhx7F/+pvY56eahTm1e+cXlJn7tdIEssLKl1MAUpRgX54lOm52bksYmiJm4FosyQ8m93XITosnCLCGbEoQxNjaG4wEwgPUFc1TJXfIvxvwRWWN9odEf5spgkr5Dlsfk0Qe/5j47bp1BqikTs73c8WzGEi2uwiT4BC5jDsj9kl4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 13:47:11.2598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6ec546-3e32-433f-f7c3-08d5829f9956
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please, ignore this particular patch, it was sent by mistake.

On Mon, Mar 05, 2018 at 01:37:41PM +0000, Roman Gushchin wrote:
> This patch adjusts /proc/meminfo MemAvailable calculation
> by adding the amount of indirectly reclaimable memory
> (rounded to the PAGE_SIZE).
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com
> ---
>  mm/page_alloc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2836bc9e0999..2247cda9e94e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4695,6 +4695,13 @@ long si_mem_available(void)
>  		     min(global_node_page_state(NR_SLAB_RECLAIMABLE) / 2,
>  			 wmark_low);
>  
> +	/*
> +	 * Part of the kernel memory, which can be released under memory
> +	 * pressure.
> +	 */
> +	available += global_node_page_state(NR_INDIRECTLY_RECLAIMABLE_BYTES) >>
> +		PAGE_SHIFT;
> +
>  	if (available < 0)
>  		available = 0;
>  	return available;
> -- 
> 2.14.3
> 
