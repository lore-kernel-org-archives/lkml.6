Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeCKTv3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:51:29 -0400
Received: from mx0b-00272701.pphosted.com ([208.86.201.61]:47646 "EHLO
        mx0b-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932161AbeCKTv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:51:26 -0400
Date: Sun, 11 Mar 2018 14:51:16 -0500
From: Nick French <naf@ou.edu>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: ivtv: use arch_phys_wc_add() and require PAT disabled
Message-ID: <20180311195116.GB4645@tivo.lan>
References: <DM5PR03MB3035EE1AFCEE298AFB15AC46D3C60@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180301171936.GU14069@wotan.suse.de>
 <DM5PR03MB303587F12D7E56B951730A76D3D90@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180307190205.GA14069@wotan.suse.de>
 <DM5PR03MB30352350D588A81D2D02BE93D3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180308040601.GQ14069@wotan.suse.de>
 <20180308041411.GR14069@wotan.suse.de>
 <DM5PR03MB3035CCBF9718D7E42B35357FD3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
 <MWHPR03MB30402C0F8B8F457F5F760412D3DD0@MWHPR03MB3040.namprd03.prod.outlook.com>
 <67E7293F-6045-4EA1-8AEF-E4B92E046581@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67E7293F-6045-4EA1-8AEF-E4B92E046581@amacapital.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [155.94.246.64]
X-ClientProxiedBy: SN4PR0501CA0103.namprd05.prod.outlook.com
 (2603:10b6:803:42::20) To CY4PR03MB3029.namprd03.prod.outlook.com
 (2603:10b6:903:132::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60027eea-61e3-4aa5-a5ff-08d587897688
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7167020)(7153060)(7193020);SRVR:CY4PR03MB3029;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3029;3:lka5dXx5BWiJQVJ4IiKRghN/P3uGdvLi7z49Q1ztj5mYb7qNFN4mY/1ycH/DOJ0Is0Ekqbac5ZsBXsRd9SisQkrBOoM8TLFUs6WbkzpDhG39rarw7Gdn3/dQIqx3hvDV99V0RXF0O5358EqX7dnMu/EP7RvpRrfbr8TYYUkbma+wSuJITDY9V12JBM4NztEn8gp0KPDx4M7EStSyhDytkTOjVZl2b4HBA471y/lqqOeOzOop3ANr3Mzz+JPvVPWx;25:A4SdYxXjcBH5XtZMDHMF5YcjMie+YFBO2HyXSPrcZL3t3RG+YMfHkajb8yjwWOQwuFDHQwBnJSn1qMMzM1UJBJO0K4nrRzwbXbMvxrsSbeSrn3dhHTEiObhgt8DGnJkwJu+X9lUbz54ZYRYf3Qy1MYS0vk1clB796w1nQq/JVsc8K59MPtq6XHSPKojq7dQEJjU3zl3kT9jqrMtYr6CYs1f3JixFaGxfKqrLqRVsFAumG6BV2mOpXOZhDrfPuQGa896prhINzAyk3k3iEOdy0DlHFtOyhEPBhaMotQ0d2+fevWqAzq1w3LmSkUWTSk1zn34yT7FJhqloVee1wHOe/Q==;31:KwlPMrIbd4l1oagSheG/pwb99th3xnrE+ddDx8oAue4/5AvCaxj+uA4Zzk1dpYc4IHsZQWlNhkm34pR/2eR8yM6B/E9jurwUgsFNS7X54Azv/GWDYr/fH0AMoKN1/XmxvlcG+WaKd1Ic87N3/ZmiXZzUvpEayZqL+GEIuQAkuBqX4iFVmnFgarUMuWFcvCRcdktXXaFJwyXMD/CTTaG6unEHaWyKdlBzR0es+drJ8EY=
X-MS-TrafficTypeDiagnostic: CY4PR03MB3029:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3029;20:eF+Qjba/v1uoLydmLZ7dIsorLAPyZGi0XoPyAfwWIV6V7AltlpaMDxh/dOKdTPLI+V8wKD8r2yZ3+w2OKVMAPckn2MuQP4UPVKtfrIXavk4DnrWLlEAoKH5rMM5veAYn8+seA9o6g6zwNRdbV+4wUVVRq4rn9Xc+lpnCafeiPapPnss2m0il2LDOKUB57ePwzZob4K6ZohPeSEF5yTYUBafGCNXNXZ0Tj/qvXi/dlHSzy0vH4+haz9fDSrjWAOBNtjEuUwoVaJS7MUoaE0koedpMft5F5prUtpe3nTpRHvpSB9GFG3yDygjOocTwJdgwxtaTb97Ab2XQdO5mvmzisytfecOcatubnrz9hB8815r03loPHLTsiHvR3dhXjwg898Ft2brcoZejM5D6g4y1kziAONz0J1NLof/LmBkCGB0sqKSEG5XrLYSdgzSUh2yO9vCHe+YwrdePiLDzLUiiVysv/N1s+BV34soJcU8LIr8OmBWUmxo1q4G4Dv5/v3R0;4:g86bQsk5BJqXTl6Cu/R49IgSHRLtex+QQyrL+y0cXs3+fO4DX0nw3BoeaCrf74PYKX99VzXe0txLr8LrkMaLfAKgC1d3Ob9rGoxg8AH8ZZZUPzYNMS6KN4C+s4J+r0twyJYZZwSC3d8Q9YqfyqZT368ile3mXpQB3/86GRXe+alUJE/eEwBb7orRGuwOD9LOrb0uYzgDHJbBKQd0+OqyhVVcQbstbCxhdOpmlAw4p1DMS/s6fwLyhNuwS0aLEw40n6+QPnZ2244nmsLg39ze/Q==
X-Microsoft-Antispam-PRVS: <CY4PR03MB3029B5D6989F18D2E95585ADD3DC0@CY4PR03MB3029.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR03MB3029;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3029;
X-Forefront-PRVS: 0608DEDB67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(189003)(199004)(8676002)(55016002)(93886005)(36756003)(2906002)(76176011)(88552002)(23726003)(7696005)(33656002)(3846002)(6116002)(52116002)(786003)(316002)(229853002)(54906003)(69596002)(55236004)(59450400001)(26005)(6506007)(75432002)(4326008)(386003)(68736007)(81156014)(9686003)(81166006)(305945005)(7736002)(6666003)(50466002)(478600001)(2950100002)(21086003)(97736004)(53936002)(58126008)(8936002)(25786009)(66066001)(6916009)(186003)(1076002)(86362001)(16526019)(16586007)(6246003)(47776003)(106356001)(105586002)(5660300001)(2320200001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR03MB3029;H:tivo.lan;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3029;23:bEVgsIuqPvqY+anIzQz34Bg2FBOfVo3qn+lT3ph39?=
 =?us-ascii?Q?GOEXGWhPcymVcy3xEczGQcgAvUbHQdu0dI//ssZx2gT9g9agZE6aNZFfxoB8?=
 =?us-ascii?Q?3k4ALKSkOTlOfc9zcFvWwe4jaXqhSMRKWKNAS+X3oTutk02NySeHVqrwVnbm?=
 =?us-ascii?Q?gcNZtFGj8AgGGxcAhoW1gVbo8o23zyYT7mmq1zE4PFtKkmXc5zgEMfGbUp9C?=
 =?us-ascii?Q?GuYujE7fiKQC6iXJCp84iOEY8BD7N6Yrn14qIboywWKn62iXdus+hvVNcQuo?=
 =?us-ascii?Q?eIu1DAbTujGgZxIIhWCpKYSvSzoFc3BlGmkxeqdUPIJk0K4/L++1WBi4mUOM?=
 =?us-ascii?Q?RnXreoOFoPyH7iyk7fSh43vv38r/vshw9nJSuYni0XBNoK02/07an9CRz2ID?=
 =?us-ascii?Q?EAn07bHQznOVmrBZsVrV9Hb/f8JtSL8KoN516zNXwCZOJIUHQdibR/bGdAlp?=
 =?us-ascii?Q?S/g5JSE2VjuaiYi2L7AXcL4EvUJyExu4y+BkGL/YR/4kiZVtuGdVRN5DTkVo?=
 =?us-ascii?Q?tilzfP/iW+rTYvjDrvc3fR98zm3in/ntT8hyespPYIrwu096zxe3twwYVH3V?=
 =?us-ascii?Q?N85TIu/1J2i0/hQlM+/WKZdCIlMQpn8vn/RdfjUHyEk89YS6Mqnson/eE169?=
 =?us-ascii?Q?lJeithEKeOhh7XYqiAiz02B7p5+qxHV7r3WCYhYpTGcibNyai2rN2ZGcsjW1?=
 =?us-ascii?Q?BlujOjL2UZzWEKvZn99lmLmnscpx3oHdVzBVfCNHd5CGap88fvWqgpXBGuPQ?=
 =?us-ascii?Q?inRMtM0Uyx8ifn2IKterTIy2czCWqoFtCA1iNjzb6aGbY8DOtfK5T0kIvV7T?=
 =?us-ascii?Q?RbgxaT7/vsw3OFEg/hhbA7+GchW5t/QKzFE+8WULl7+mgXFhZENqw+cAryU1?=
 =?us-ascii?Q?aQeohI8+xSfMVZIonrDsuJmtr410GWEMxgbzyIG7UUIiVoNZqrrEvsgnmRQ7?=
 =?us-ascii?Q?gT+xCbkeVnfOFoQXifl49mqFDKj8+5SrxJX+08RE6U1eWoBQA9xxCWXpwO4s?=
 =?us-ascii?Q?514rwo9iCa063RmXZCTe32+eWp0zhWuS6PRIkajsA1lHN0LFegLsoaSdAQkw?=
 =?us-ascii?Q?XYuprFMFDyizQEG4QAO0nqBROzDH0TvQcXWQ5HiczZq/FN0OubGsEOWSzpWs?=
 =?us-ascii?Q?wjfVWhL/GSO2Ks9VspY6CD4Ef2Gy9aqoSpS989tmvtU5oa9qg+ZvBseUv4Bs?=
 =?us-ascii?Q?W2LsE8XkosrBs92Qr8E2eSSya/h2IvD6I8e6Fpnt9ngBUUKdcQxDgH1RvaCk?=
 =?us-ascii?Q?tMC9WNTU5UXjbb3orxUq1ZdFBGmw2TYOr9S8jYrb1bibaZaW7EpPFqmO4jCm?=
 =?us-ascii?Q?Md2jCWufklr4v8v1W/2YnsUO99uUk3PhX163YhKuleE8pF6sEOy2pj16s4L4?=
 =?us-ascii?Q?4fvtbv3Bo5wT5OeAIvUV+1T5H0egyWH5tbANu+GIQckjuGFgcGEYkwpXNfSC?=
 =?us-ascii?Q?CeaaM3F0T0YT4s++F16InO0P/agcVs=3D?=
X-Microsoft-Antispam-Message-Info: wxSvfiAAzXgDusveamTTl1fffp/D+Myj2hNozczG/QSWYBnji9eSg5zDYcVj/VcypTQxwmh47hUxoCospMWSPCv107iInS8OcI4H7k1gW2TeuqzwVyfTf/FccipL77gm/pSypRu9bsqk+hwb6jS1cM4JBVlAizdUU+CqHqBu9EiKW2yuZUNdzZZc1E/cStAu
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3029;6:h98x8iwQc0vofiQFxjZg0QpuZCBowjghUtDgQgaNYJ/b5/40bux1y7tUrZDGI5F1ka6iGYCJ9qdpihx3wM2BC0rjIawXBcHVHACijNABDFbZ17kIoGyz5yT9YOp0THAcbVcm09Zu0I7MCsBFvam3myIYqstBG2Ozlwnc0m1UgK20JSM5W0F/CyG235ssE0ewyWBs3m3P5NlvMCFCPiw34H3mRjw1MunHhslB1uCH8zIGm3RcWDJDbEAyvEs85r5myxj4Hj6oQktbSmxPNFrT3U4yLXN9r6ilXXq/bFIrVyTmXlcT2AD2tMLpccd7BK6giA/gcMrmsfVayUWIyHccKaCMamD8HA6sOCReCNMk3TA=;5:1p4L3N6qnvofie9WsfpL5P5VRzaNSWnz0CON7VEg7JTPIuRDd3H9CwxtQ1KLSb4GHpQx+ZLUsKIpJ9F+AGodSg3YlhIDfCSWB9P6tCofcu8Tneo2FyCcSRgMABkd/eU8++hljbn8oGbLPc92cAqsFjY9W2hKfIch4B5ApjAl5SY=;24:OxEEYA2S1ifO823Lgve8GXc8mBbpXLa0lhZghIovMZROvENVR1rEPhBT0HlrvVVLcQp20MCqSp2tVbvfr9nPEGOGJAJIpv6RICLR4W2Lt2o=;7:Wju9FUULQfAPczNwj7iNbxNHpVs2kgpO5Z9cb25qLTQh2MAkIGedDH4pDiWeynfxm2aCotZZqJXo6TL/HQ7JuliNk3++wFhJtziQhln2Z5td89it1mXkjEuqHueRixi6kxSBjT75NNWHkbO0mRfu8FAl+TvSiPHEpdEr78D233HnAVm3lwO0gVPeueRoAhl6pNW1mZl283QvY1Z/nRuwguYAOZ6gqVHYRD3zf1eWqHOsfAyEcvoL8exUye7N+Euv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3029;20:Yo2c5Dk0db21Y+fEfu3Ce2wyXhsOBzCN3ybC6fSDkkpRSGl2v7IoKIc+ib8DOB18sOlfexwK1Zm8q/nzDQ7R81a4d/hKtsDwD8xbk8k2Urtgr3jBLM6dX5kDoltnM2NPZQcTmbgiab//iFW3flPrLIp27UqS98PGYEPXa29L08s=
X-OriginatorOrg: ou.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2018 19:51:20.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60027eea-61e3-4aa5-a5ff-08d587897688
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9c7de09d-9034-44c1-b462-c464fece204a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3029
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=855 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803110252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 10:20:23AM -0800, Andy Lutomirski wrote:
>>> Perhaps the easy answer is to change the fatal is-pat-enabled check to just
>>> a warning like "you have PAT enabled, so wc is disabled for the framebuffer.
>>> if you want wc, use the nopat parameter"?
>>
>> I like this idea more and more. I haven't experience any problems running
>> with PAT-enabled and no write-combining on the framebuffer. Any objections?
>>
>
> None from me.
>
> However, since you have the hardware, you could see if you can use the
> change_page_attr machinery to change the memory type on the framebuffer once
> you figure out where it is.

I am certainly willing to try this, but my understanding of the goal of the
changes that disabled ivtvfb originally is that it was trying to hide the
architecture-specific memory management from the driver.

Wouldn't (figuring out a way to) expose x86/mm/pageattr internals to the
driver be doing the opposite? (or maybe I misunderstand your suggestion)

- Nick
