Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDEQIA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:08:00 -0400
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:23584
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751277AbeDEQH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:07:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Thu, 5 Apr 2018 09:07:49 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, dnelson@redhat.com,
        gustavo@embeddedor.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180405160749.GB12703@localhost.localdomain>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180405150748.GA5716@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405150748.GA5716@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:404:f5::26) To DM5PR07MB3004.namprd07.prod.outlook.com
 (2603:10b6:3:e3::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a08c635-51f9-4baa-0708-08d59b0f6412
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3004;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;3:uejzniPb4ul9h48mmnIB8bETvZhoWbO8Is3JnscvhqdAEswK+6DVevIgPL51uHE039BCFw4aXDR82aWlxFTDXh2bjk15GLB3ilO/H1HabOoE8EHg4Nem3gmh3tGCW3h6HiVMC0ZMD6sEO3TwcGGQwO3A8SMxqWg8NZvUn4bR23gHiY2rvwyCOf/0UBJCRYh+b1bfFLJakLbSTr1dg62MHr6FUaRLbzxvqkxJ1Pj0oYI6B6DGiy4RCRB3oa7ubVIp;25:/DASQNhWm0wW9ls6PMB4BjS1fv2n5cykVje4UCwqAdP8cCNHu7IqNDuHLXMiSmFEZOkdSOFIbLd5nk6Y/9R+Gr+ZD9fVcco4wXP/M9FuDDDXMoPkUrV1iTWqFfphTi9VNeRM+niXoH1Er8wLjKjyLx2ZK6bJksFb7xwYio6eSiuttnzZCZotltDmz2BBpXV/GYjh9kSZscVTJRa/Nq1XjpF2fBiZpNFriy0x35+Yq2KpPEgXo5/dlfseQbQ7tu0KO4kd9b/bzzTmu5f7wD99MKSH1YOCvPZb8cW6Y6phZYsKY252fJJwp2KY3EFKUqy0CeEOVc1mLonmJ3z5LWPA/A==;31:HERCmsfYQD+yZkIuPjr7yRbRb/2CoepVfrkNvE6gg8xhur4ni2Vx9kt+qobgQjXBEwV16ogEDnPv4VtQ/2ImbQ0QUbgMGw+7dOA5965Ije5AwnAel0oU4uQxrQm/OxLYcJVO8uCWLAqVzWSDU7z6BrXEKX/Rv2MWxMt9/iSRfXWa6EcDdKHdHEF9SKY+HA0CyBf67yHGNhFyCA3LSv561i5KRvYI72+amSGH8SCM26U=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3004:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;20:p8YtFXAAbj7TD46RRLico0xMPQBN16hMM7Bfx9BlZfwt+DPGflamZwriMC/2TaXJxCydmV3jkQqV4u5W8ZpejH/Uq9j/6I5HiPNzLm9oBkpn+K5t8SAZwnHfYDt4BGwQ6f1H8bne9GW9KG0ikDbmIIFxf9pra3/1ahGEuZ31H8hcpWzKcliSGaXIxDppWE3xNNrSMRfjirexEum+rdKJwsRZyfq1aINQcDg/5mTWJFl4v+gY4fcqhVyvsl3dVn7Uz2EpTHoCIZRb/ydHaSYMOB+hUJyU0UFOxwswj/CLygqcwHvMFJ2bQvVw/OJzEM8Ugybh6guNtTfl57l2os08CK69LcvK6P2KVTd+Ytt2re5wab9hhZ4Fg0p+/8D9yWkMztGWXyKr/3eR1bkPtgcQ59TV7rz5xApRFxwyWnNBp4snV4cRU7QQAy2bkwlztdtwDu79NeJkggxvFz0Xj6cHJv6yoBgeZmtU4wlv1c6NjgCmTwbPa8kfoAy9qkMoo0eybwxrm24gCeCfIKjtP3DLb6dNnYcN/FcsVR5eM7XSnGHrEuOejrzF4z0XVLl/Zp+a3wpNCea72m5Kpd3TJLDcFOEXaOzJy2ElWzFGj/6+csE=;4:aqtxVgBiOxJJ8n2jHTyMVB09TuNRUO2DJKGKQdBK3K/a2mZDLqjbuEn5DpCRYIOm2r+E6p2Ebjp8VpNQiEMHG1kIFsj53AISPc6t9zoSKE2dXcnbr7GsEEBs5hdcuN5/9cbJuCCbgWHVCYxCNDN1zz5Ih6SR1luKpC1M2keDVgqPmpFLfUzIGhQQrW36M/BhjPgubKFFHGPhAnc5Zcn7yXcknHJnQPfnWKmZIalpRKXnkeQFGNZZwmU9M5HyTdx/OhkmVjWI0mAVmYEHWUOEEvWAXdcgvb57YRioq3jU5BVF54HPOeHEz+lJyPdnlwGW
X-Microsoft-Antispam-PRVS: <DM5PR07MB3004178A7071A45D3CEA5AFE8ABB0@DM5PR07MB3004.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3004;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3004;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(366004)(376002)(39860400002)(396003)(39380400002)(189003)(199004)(6666003)(39060400002)(61506002)(47776003)(50466002)(6916009)(316002)(6506007)(53936002)(4326008)(9686003)(229853002)(42882007)(386003)(186003)(52116002)(81166006)(486006)(59450400001)(16586007)(33896004)(478600001)(55016002)(16526019)(68736007)(76176011)(8936002)(6246003)(66066001)(7696005)(8676002)(106356001)(25786009)(107886003)(23726003)(26005)(72206003)(81156014)(33656002)(5660300001)(305945005)(11346002)(1076002)(97736004)(446003)(2906002)(6116002)(58126008)(345774005)(105586002)(7736002)(476003)(3846002)(956004)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3004;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3004;23:ObYLouoNAELousZsYa7aem1Ok6Lt0eAdjNyga3bmz?=
 =?us-ascii?Q?qBfzKobG98C8H1UAzzJPi0w/pll2wRxAvwsoWgLbJwaWkGUdxE5jHVJvubeX?=
 =?us-ascii?Q?mxGJyyip0rcU7gePNlC8Z2HmPytyM/k7PejIUddbp8/kxmPOc98nCpoiO+zv?=
 =?us-ascii?Q?kY1EC3o+MLBW6DSZ+cAIosKAysUhLru1q15X7vc0UAy6sM7pI/MizHOiBk4/?=
 =?us-ascii?Q?9q/nY5TDKOKDrnE6KspUWPkPQfqCdmBAdbdEO3ACm/kN7+6H9NTrwhSSfC3n?=
 =?us-ascii?Q?+tNfJBobtAuwcxDlpqehRpN3nHghZdZqo+4htcCKrvQLh7ZjNSElqrNRH5PB?=
 =?us-ascii?Q?tQkdDYGXRpyy5TDhovGgdOI/0pErLvoUpChaptadK26IUMBonJqQ1aWWe3tH?=
 =?us-ascii?Q?Mha2EmqhJxLYfRGXYoE/G7reCZ2YwseGK+x3Ay1TBWmqIvTKyHrpA4+PVK+M?=
 =?us-ascii?Q?o3oiDJLvPyTz9Bt3miTKgY//1vGRgEIxjW5IqLQ4p5o4hWVu8wEi+xnLqhK2?=
 =?us-ascii?Q?H+xENDXz7R/hj2q/WR6YeFvgNfX4PNesK9prZyHl6REO+ncoy27vFFn4Fs/H?=
 =?us-ascii?Q?3hTWwAaWa1mzi0G8jkeySyjffgVag8So79niHlW24/JXfnhp6vjeQvtN4Jak?=
 =?us-ascii?Q?NO3mVdk9zSjGWXPfvqdg+6tTMBYELGZHrGATjhnSePTeBwCTY8kydAKSGnex?=
 =?us-ascii?Q?+f8lxvTBtHT3y+8YzeIdIftd42xU11hm0/4N+kpPSjyQ0CMgBuKyzWRPxHHq?=
 =?us-ascii?Q?79TSTmxIlHvWsiFZEoIQiyY1AsVGjE1vtr1/8gXZV8YnvEe6Os9+BDUhvvbB?=
 =?us-ascii?Q?t8psEJ0GzAu03jg6li8PRZ7eMywbS+XQzyzNpRRNog/22RWRnKW7+yQgQyhd?=
 =?us-ascii?Q?iik4PiEtm3rrbDKn46171QhZxe5fuRwiAs0TONAX4Z6D4f5kLDq0gVg3JXGU?=
 =?us-ascii?Q?9JUU4CL3aFgNsGxaR8vLrxo+ZK6EaB8Nv7gCdQPkYvm+UcpNPZ7A+m/DkKfU?=
 =?us-ascii?Q?ixykH3N8VHV+atauN16mu7CaMHfxVEYwiCO4S0mSq8tvg099YdttW4uTETEW?=
 =?us-ascii?Q?AqyvWs/X/JbLSwvsNPopHQ7Jntmpn5UtVJxTNmVv4LNvhEz6jETYzTwWThpY?=
 =?us-ascii?Q?IQgPZ/Wo79drZt9PLEj3djdFGSlvqwArh9Sk/RcNhW2D1dhRNvYUBepsLYRL?=
 =?us-ascii?Q?0KjsAaZI00hkylBV9Q9GDbr0HC4ZEWLJcGZmjtgdKHqgu1058MOjOmsxtFig?=
 =?us-ascii?Q?bfdkKP7QeeKOphbqQKizYaxhOUWzuyLLEarjmyoJqVdRptQUIzEZPVIjnApO?=
 =?us-ascii?Q?w/rqjxY/8hkI7p5r2IuKVaPaNvW7PezjaG2PXkNWNXQ9tqjmFRwo7zmWD5Ct?=
 =?us-ascii?Q?Ld9h/YZo3Xwv/qF8ljzDdYRFEpWvTemGGDee8jfEZzKlog4jgvr8W2CexV+w?=
 =?us-ascii?Q?plLG1pmbw=3D=3D?=
X-Microsoft-Antispam-Message-Info: sZxBz1X7YwBQK1/2YEgvf/M+jGOt/Ix/AniGpXymjbN5DiZkBuct1MRzQBCLh+gBcd89jFNYGwTM4Q/8jEKjVJ1QfaG2//n05gjuHCGVeACRtqgoaerioqU/71R1VVzTE2rH8gjo+5TD55bcv9AXSeWttdqlnmL2daPZ1sYy3+AVOS/gw7x3VRbJSL8QGBox
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;6:Y78wb68g/PxtrTdXBWk231+IutThg3IC/mLuBd+wdRMdw+nB7uBIrY73BLufD+l0gEgwIzXAnF6WQxKobPC4OKgSQ1JgtNsYEQ8ManukWvaSs5F5BvleSGF5krm35S8wC/MHLWb2UTKkkAQcX4Clw60WcmRLxAp+/1HsGCW654pPLN41xqlnDJsgFWwBK3v2cLQ8omCu8dKNVZMG/09yFBu65CeeFPELZyK2YtBjOZL94NPUaOE6d/wY0/RVYd1MODfC6nvz/j2fBr/eDxWRpQk2rQd3luTzY2lPpa3pKtGbDH+6ZtXMKW72OCnHuxcCO/uJAR8hmoDmMmtC2jltNa9WlPL84yC3T/wBIA3rnb6VDWgRTCVoqiuXQCHiKxq3tKWFELOLPwl2Z31sr8PIlRgr8io3ur+sBR+cSTXGL+4uuIjMtPPDM9KC0AnI5dCNBFmGICznDgqXdDGQyjPymA==;5:pImwv3zNDEBIknOoVMNzxAKFr9Qng1MjoeiXhGVvvvSzmbE9GPc9EvkETTf2EqDodgUUiwlPAs1QvLxjCZQ/OF8jPsWqvmjcD6drLTUFcb8JJacmrEBfHbv0P99hoHiIePmWgLNtLILziOPPX2AiOUj5ct3ginYfPeznaFdZ0wE=;24:jzivD/0iuD/I7q7+tLgMIUQz+P3BU6ask6KIrSStI7/2+GzTFf4TxrwCy69NYV3YQqouV8lb3H6o0HgdPX25FBYoxn1u6EUShD3vajFT9Ls=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;7:EUI5zQOtn8JLYw5e5jOu1wdU7Jqnt67J7paD2WhJxqjjZGpb78k8y8R54nSq0ZeuH51pDBGHikniIEsrV9s6qao0edGrrdqth9LsOZBjjukKlukM5vrYv96Gb0EjrLudWQwoxV2SJyfhsBicpXvBVGtJBvGjRYucqTeeFDtyVvKKLYVQEJpOzjEmaAMDs341yAL0hjYYhohRovefWQVJOZJQmwa5pPwt7tGUNA7t59jSZX65DeqxG9EFKpD6P/Ns
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 16:07:53.3979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a08c635-51f9-4baa-0708-08d59b0f6412
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3004
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thank you for your feedback and time.

On Thu, Apr 05, 2018 at 08:07:48AM -0700, Christoph Hellwig wrote:
> >  struct xcast_addr_list {
> > -	struct list_head list;
> >  	int              count;
> > +	u64              mc[0];
> 
> Please use the standard C99 syntax here:
> 
> 	u64              mc[];

Ok, will update.

> 
> > +				mc_list = kmalloc(sizeof(*mc_list) +
> > +						  sizeof(u64) * netdev_mc_count(netdev),
> > +						  GFP_ATOMIC);
> 
> kmalloc_array(), please.

In this case it would require two memory allocation calls to kmalloc() for
xcast_addr_list struct and to kmalloc_array() for 'mc' addresses, becasue of
different data types and so two null-ptr checks .. this is what I'd like get rid off.

My idea of this was to keep number of array elements and themselves within the
same memory block/page to reduce number of memory allocation requests, number
of allocated pages/blocks and avoid possible memory fragmentation (however, I believe
the latter is already handled at the mm layer).

WBR,
Vadim
