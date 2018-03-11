Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCKWIg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:08:36 -0400
Received: from mx0a-00272701.pphosted.com ([67.231.145.144]:40158 "EHLO
        mx0a-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932334AbeCKWId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:08:33 -0400
Date: Sun, 11 Mar 2018 17:08:24 -0500
From: Nick French <naf@ou.edu>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: ivtv: use arch_phys_wc_add() and require PAT disabled
Message-ID: <20180311220823.GA4074@tivo.lan>
References: <DM5PR03MB303587F12D7E56B951730A76D3D90@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180307190205.GA14069@wotan.suse.de>
 <DM5PR03MB30352350D588A81D2D02BE93D3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180308040601.GQ14069@wotan.suse.de>
 <20180308041411.GR14069@wotan.suse.de>
 <DM5PR03MB3035CCBF9718D7E42B35357FD3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
 <MWHPR03MB30402C0F8B8F457F5F760412D3DD0@MWHPR03MB3040.namprd03.prod.outlook.com>
 <67E7293F-6045-4EA1-8AEF-E4B92E046581@amacapital.net>
 <20180311195116.GB4645@tivo.lan>
 <38CB7D59-7F11-4BC3-B73C-C2F0BF16EFF8@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38CB7D59-7F11-4BC3-B73C-C2F0BF16EFF8@amacapital.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [155.94.246.64]
X-ClientProxiedBy: SN4PR0201CA0009.namprd02.prod.outlook.com
 (2603:10b6:803:2b::19) To DM5PR03MB3033.namprd03.prod.outlook.com
 (2603:10b6:3:11e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b03ac258-5642-4f17-fdda-08d5879c9e87
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7167020)(7153060)(7193020);SRVR:DM5PR03MB3033;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3033;3:ci90GtIUb4f9lxTmZmPDcIqgtSrONEkpq2mVENiVQiqD8HK2GfpEOwhBrWNoOCCHA9gisvFRzBWSeYt8V2eGP/fssuyxq6pJHaxpvjDV2Lz/+vR9z/zlOVjS55+zHclTIBCH4jLRPetzZRaL2p4M66nYab5s+hAXPuiVRQ1vVSe1AropdsmaeVmPAxD6ssbx+dR2jN/B5BowtiqgPsNcDDDMv18tjp0nA1QqEoc4/GnrH4UGXTYLtqYxZuXgxq+6;25:P5+a8g0MDpoQB6+vOTKXaV1ZafqYTnUP9QSH5rlzVFPYbgYNhN6sYQNwhy6QRxuPjqBlxJsCKmYu6rz76DtNBhpVe+4vDuOn+s8fvigqnc1lNWwY3aVP5+0bdM7PghuIAfgl1+w3GEuMsJs+lvZn2D3BhFlIeTkhbeW2bWBIFV4oD8RZ49lO63JjO32a/iy1mvnD3lQAeliVe+0moYZrhkBlo8XRILlg8pXI1NCN6uqpa8vzC0574E7Wi4lfkU63o3MMO0KuWhDw2kyAug4+onlfX277zxt56QKhTJirbdOYJu0V4mfnAp6BMHTZCiyCC9FAqN6sYZXqX+Nr10WDDg==;31:mR60Sa+QEunN4fk7ZTBRkHY+fTSAwJwMiyr7AT4xP3Ljo+PChcIkGKp8KUXYIkRA4r+4CWlTDTR0ISEkn73pv8KZ/9z6GcQNoPjdWslG53nbSCVjnzSmCmPORm18ijmwgooEQjd6TqW6TYRNxDAt50GE+k9vLSSRF6rs/Gl0CPotUU5/0OP6a+EFiefSI0WG+09FNRddTYTf7MuWlNGsqsMN5SsSwqqp+k5SMrFKfbo=
X-MS-TrafficTypeDiagnostic: DM5PR03MB3033:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3033;20:hScNm1TXTsZwYV1rG9qSdJx2yxbXy+jpLazzqTKp1fbB1nonekibstuxuakmFINGh6jQ5koK6dMJUiFEzgyT+FtgGIGivkyjAAllRncabYgGtfaSKUWanD23mlxtkHs05svl3rO04CHaaCSae0tUM1mhqg5bHRkLvollXxiIueufPnmWEWnrlMptCArvj/N5DuPpQ5KkgIuSO0RFKdZ9F+Fvkgw8WTISHv98/g9EaDlfFILwbtsOd1hyM3amGKsP9zcEDotkNJH2rQu5c8vOrTYtzfpoZ2DeEI8Thui3QcruA7k1TCecTTZP1ZwK/A2Ndx0mpWdTAT4vJZpdnnlBu4dS64vDCKVlZ/Z9VCuZBCgVqtHyIySirqYUXkeZBJqdJq+/WkojF7IgAqmeXv+DW2u9KlvAw+7Z20U/5CTGNVb42QOepRvW65OdtNaTnNB8BFElJegitsZZW4slYjzMc6R8Ka/48uRY1PBrWms7Nid85lwuYCGzPGvRz2+NR1t7;4:V0wMLK8F58KoKuSZ4lk3KpU8elZDiUjgaxSXvGlN3A6QHVtq8PteyX8GmSXD8xJH/lScjJV/1SNXLFWnQE08emEeioklLx/ctWGtzYwyvQEiLYSa1N2e85vZC+zAgxmNR6JRJOL3A2TbC8a8SYB/B+rNR/+iO19hOCWnT+7J4t5sZpkXwTXFTrk9MWCasixBtEvj3L5GSbtmxrGEG/CmbVFqzeGpqTQnSCSxBiO8d6zIN6fWvIZVBG6zJFZjUXaN9Y5uE8EpKhmy8/KWFsMj+w==
X-Microsoft-Antispam-PRVS: <DM5PR03MB303397FD7B0C43F080ECE895D3DC0@DM5PR03MB3033.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR03MB3033;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3033;
X-Forefront-PRVS: 0608DEDB67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(39380400002)(199004)(189003)(52116002)(47776003)(54906003)(186003)(26005)(33656002)(58126008)(16526019)(93886005)(786003)(6506007)(386003)(59450400001)(478600001)(316002)(2870700001)(21086003)(106356001)(36756003)(88552002)(69596002)(2906002)(66066001)(53936002)(76176011)(8936002)(55016002)(8676002)(2486003)(23676004)(52146003)(50466002)(229853002)(81166006)(7696005)(81156014)(105586002)(6246003)(5660300001)(6916009)(6666003)(3846002)(6116002)(305945005)(55236004)(2950100002)(9686003)(68736007)(1076002)(75432002)(86362001)(25786009)(7736002)(4326008)(97736004)(2320200001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR03MB3033;H:tivo.lan;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIzMDMzOzIzOjhlVzNseDUrUm5Dck1UQzRaNUxxc00wQk95?=
 =?utf-8?B?VExIM1Uwa0NUNldTWE1xYnV0WEpBMkR2K1ZZV1JZY01GTkNjRkF4d3IvNkN5?=
 =?utf-8?B?R0FmaUFVR1dZV3ZQR0ROajRUZW5NNGczN1ZQamQrSmNyM1dxcGFPVTFyWWlE?=
 =?utf-8?B?R2FvVFJWWnJLWVpsWjBqNlRJR0l4VHl5YllPOFN6LzJ2ZC90b1kyd0FTZjNM?=
 =?utf-8?B?NnUycDA3UXNkNTRZeloxWFpQTkFXdi9iR2EvR2xTTldFdDJYaXgveWcwcnZy?=
 =?utf-8?B?WndEb1cxQmNsTHR0Yjk2R3BSVnVwcEZDN2pzdjVUSTk0cU1xY2FzYjYxa0lD?=
 =?utf-8?B?VVczelBKYlh4djBITHRlNCtvV2hONUtXUmIxNkYrcTNVUXdnOGgxTHhOSG9J?=
 =?utf-8?B?SXBNckM0YU4rK1dlM2hYRmxxMGZrZG1sSHQvQ2VVdldSU2V1Tjk1YWpyL3hq?=
 =?utf-8?B?dnc1QURxWlFsdVZvQmhWZzQ5MHB2RHJaaURQQVdHYXJCZHRWSHBzUHZ5MUcy?=
 =?utf-8?B?N3oySXJLYXhvK0hnajBSbmxHd1crUVBNRHNBUlRKQ1drREwwMmZtUUdPMU12?=
 =?utf-8?B?N0JnVHpEOWk2c0g0UDMwSFlVSitXS1M2cmd3M2VVcU5vUmczQ0JJRGR0eDhn?=
 =?utf-8?B?cndvMnpabjQ3M3BTSEZXQWVOVlZFdXlVZmtKUEVoK1drL3gwbm1rSGNTMEVz?=
 =?utf-8?B?ZWVYdnJjNDk1bnZ0Uk53cC9HTU12N0w0S1RpUWhmdi9Xb0lHOEpoVWpLaWRr?=
 =?utf-8?B?aUMza0g3UUxFbmpQckdibmZFL0FNRjZPeHRKYmhvam5iaVY1RGFZSmdVV0lN?=
 =?utf-8?B?dEtQcEtBbUdYeHgxRjZrVE9qbWYvbThLbWwvYlpmTHhHN1hYUzFHVFRDUE4y?=
 =?utf-8?B?cThPbUlQZ0wzSmwxTHllTzlKd0dTVERSZkVhUVUxc1YzOVo4a3ZJd29FVFli?=
 =?utf-8?B?VjZXRW9COTJOMTZxNDVkSmVQNEE1WTBZWE1pS3JIemFZN1VqUjFFK1IrUUo0?=
 =?utf-8?B?UHRBbWdRcEpTaTZBcHhXank1Q2hpK3pwQ0ZLZFlsVGNSSkJYZzhUa2hscTRz?=
 =?utf-8?B?MUlSTTJ0U3l6d0hTUFY0azRRTTh2dllkS1Fob1dGSE9BTk5sVzU1Ymo1VEFH?=
 =?utf-8?B?dERCWXBQR2QvaElCaHhVSGNZUVVTS1VFTjNNNm90WXIwUEhNNWhNVlJLS0g3?=
 =?utf-8?B?SS9lYm51UG5nV0EwZWN4a1h4UlpWOERHcG51M1RkWnl4SzJnM1dNbGhvUVVr?=
 =?utf-8?B?T1dNUGsxemFtc3gvSVRFcWE1KzAzcVROSHdrWFV4ckNZNkNsakdiVjZBOTJh?=
 =?utf-8?B?VUtJMkFjTkw5TytuQUYveTZ0d1ZxbGV5V0tPWUg3VHFFTFlxVisvcDl1TWh1?=
 =?utf-8?B?R0x4WUcxYXJKRjJkOXhvaVNSMXBoZjhGS0ZNdnJneU4vcnF1NjFWKzdQTmNr?=
 =?utf-8?B?UmhLbE5NMkJLTERnQzU3aFZBdmpUUEU0S2R0aU54V3VEYWtFMlErYThaV3pG?=
 =?utf-8?B?YUE1cC94bWFHSkQwTDVrMlc0dlgvYmNvdmxpVFNUV2JQbU0zdytBL1d3ckE0?=
 =?utf-8?B?cGxORFZhSGFmTXNtMVN1a1JlNHJRZWZSdGphWjZtdnZtMkkvTTZsQS9jUWFz?=
 =?utf-8?B?RzNGS3hHaWk5RmhqSFFteGhwYllyMkxCOFBibDdxbzgrT2Zwa2J2T2taNHlI?=
 =?utf-8?B?Q1NPTnVlaE9xeUcwRW5XRjRiWXZoLzFqSVZIY3RFYkJOQ0dVczByT2JaektN?=
 =?utf-8?B?M2RzRGsvNWE2bWI0NzJiVW05SHlFeUZreDlzZWlRWDNZeG5DajM3YTMxNkhJ?=
 =?utf-8?B?cnJuQmlUOWJleGh6em5tQTcyRjdUWkg5N1NBc3pUcE5nNW02TkRhNnVXVEVT?=
 =?utf-8?B?OUJYbWpNVGk0RmdzNEE4QWIrVzQ3eDd0MWkxSHhVZ2hWcm9sd0Q3QnErM3Nw?=
 =?utf-8?B?R1g5aWlTNHFHSWF6TytyU0hYK1VKeGRVS3JnbTk2YjVlVmxJakU0eUNqMGky?=
 =?utf-8?B?TXNFRW5ra2d5NisxRTl3S1R2OUkybitmZmd2Zz09?=
X-Microsoft-Antispam-Message-Info: ht7mzbbMpz8sRmssrLdCpARG0xuyqT5RJGKMvNH1V7f8WcSmH4My5duJutmgPKep2hxmznPJbg0+dIE2NuEcL2YLj85+a2EpBgkRjwYV8s/IonQTDLRyf87/m9V7WTLUl/U0YWt2dRRm4Jo8tNvQrltX5DK9KRU7KR5zrvivnWYlBSXzBmAuFFV1/DltL+CV
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3033;6:MCMqlsvmrxEpQRZ9swmlt60lClwvDpNJmD9jFrg2f+zq4IN3OOXiIbEoJi04erGqVUrVmH730XbxSR9v5BodGeP/mqW5XSPCCRVqVKJtAx2o6RfL3VwvcUhgEf+guEoJiIHl3DFVRnteUiGb289cQR0Z5N93khf6cP/Vs11OnhVLygKSFWFcQnONAiBcXZSfyPAKz8JJaR7Sysw59BBEeq5rejRR62CILPWE1lBdnGj7r6Dp4DhtaJgyAQx2pn9r1jNYa/Llv3xt0+m0uh+zowhSkrLS64ezdgXbRltm/i8yM9NoPwBV1i6nygdGi0AE6GxNKUNH39p5vKgljpTdP0VMcNT/MLQZKO6c/mAAypM=;5:0SyBKy0SQrjuz+ku9ISISeEfzAmYT5CBQ/FPN+hWLUJetSZ0//pVL+DrUcbCXO8d2DwVVUkOOJlIkhIgaRmyyi02odM9fIoG3Tx54Mf9hT1mTLsonqbl3hlb8kD2od1++g8zSwlmAAJ8iH8csHilRJmb2UVbR9lYDyR/4WlLH8I=;24:MSUrC4dx2EBqawpGiOYDpyPusOxcfDoiYkWFftepm9wFegpvbDdqkajLjcH4diIwzL3KXcQ5ST5qdM9JXYouaHW862FF+BoTcDslKpMPHZY=;7:NEKpOEBJLZ4RkxbM+UG4vTYN8SKOwHMA4JcRg4onLjitI+Pd7Wh2hp9vD+XHc4HTIydDiX/A4/U0fuv5xQ3XECIIZWp3+im48Mjt8mBbDhixfumxaC7YtkfakgqYA0zS1LgXy/hc95t/UD7UVSua1mnfx1FYAeNchWh5/2sSRvEpkiw5Da6/SnRxAarcYC6xUB606FRezO1Qn0e6MqFQQbCYY4UpI9Alnxis3ElM7is6Rz2HIs0hbcMFTMnL0lEA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3033;20:J6EwnyJJ89f7jiNYd236FTckztGyCPIcNB0tnnVzObosVJnezKnbcYfBG9EGk+PPF9XmnOxTUTDCyIlLjS9nIxKaFtks0N/WoSB30z4gFhZ0Bqmt5G4eOOzvwCde+QZDplip3IY8NmDMPME+09qi0SbiEqsb7MlyEvv0nDsywzg=
X-OriginatorOrg: ou.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2018 22:08:28.1372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03ac258-5642-4f17-fdda-08d5879c9e87
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9c7de09d-9034-44c1-b462-c464fece204a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3033
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803110282
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 01:19:03PM -0700, Andy Lutomirski wrote:
> From memory, I see two potentially reasonable real fixes. One is to find a way to punch a hole in an ioremap.
> So you’d find the framebuffer, remove it from theproblematic mapping, and then make a new mapping. 
> The second is to change the mapping type in place. 

For the changing-in-place method, is there already an exported API that exposes change_page_attr_set without first
calling reserve_memtype? I can't seem to find one.

> Or maybe you could just iounmap the whole thing after firmware is loaded and the framebuffer is found and then
> redo the mapping right. 

I guess this would require a lock so that the ivtv-driver proper wasn't accessing the decoder's mapped memory 
during ivtvfb's iounmap-ioremap window. And a way to notify ivtv-driver proper if things go wrong? I think this method
would be very awkward because its not even memory owned by ivtvfb itself.

- Nick
