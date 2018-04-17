Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeDQTBd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:01:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751836AbeDQTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:01:30 -0400
Date: Tue, 17 Apr 2018 20:00:56 +0100
From: Roman Gushchin <guro@fb.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] mm: treat memory.low value inclusive
Message-ID: <20180417190049.GA3752@castle.DHCP.thefacebook.com>
References: <20180405185921.4942-1-guro@fb.com>
 <20180405185921.4942-3-guro@fb.com>
 <20180405194526.GC27918@cmpxchg.org>
 <20180406122132.GA7185@castle>
 <20180406163802.GA16383@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180406163802.GA16383@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:1d6e]
X-ClientProxiedBy: AM5PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:203:69::16) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:5ENuEHJV1IMcJJcmHrstOvAMAOSmWLAESKdR2Qv9qRVFCjYv9BY/MzkGIrNg0qtTtFPcmp+1xK8YKDyuL0YtHil9MQUbeGG55nopLtBufHIg8AnMMODFJ9vvizlX3sdamdj0rlMveF642MjIWW8wqpmypf6wOlUXIeuX9BpKOgYqNDs0fw6f9SXlvE2VhT2nqvBuLkGmAGG5d+N+pDucAxqsC3fSVcMit3L6f6UuAtxsXqmF8jSzg1lMSa8Mor24;25:51TRHOsRhzVvsizjPJufEXhVW6mWgwxNu9MaUjULGhsQf/36NC+8V/UVBmM1Mc/zZasqD9x5m7SXGusCEa1DlgRgxq1EN2s+KP+cKW+kksu4TJaOtUBuDx311LUFoU0tMC47TZ3c2nyBjfN5Kdlhseb2km1FXQIQu3PvEYT+mtlAkY+WCDMWEDylPiNy882kWxKQUOtz44er7yrWU5AQBXA3QqfCQtsfX9Cwp2WlER391kzKiV1uH4Q9LgurngtbraaAKx53+0fU6RSJFLe+5YI3GwXILmrJqbGk7xLWlkHQt62kzW217BbjYAMdj9RMBeSwIAGQOAeZjPAyCHQxmA==;31:l0Em5RmMHvb4s7zGKpOEYZf5lXGT3TEDr5etMUYd7M9CdgkHMaE8T8Jp57HEk50ioDsdiH8a/H258DorE8l6mKBt32/w4bbPj2YobBD9i2h3UP0DTcGNbR5pL2RF0gkjnivjzoVZafevhziHMxb8N3WqOe0N2MEPTnSxpQ0WQaLCer23YK7XLG7y4wAsvAbyY8nBkp86wthzvQ6go3iuvQiM9iy+UyfS/cmdktJ30ac=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:AZOG0TrZ7KSsusrxYaRwJDvn40XLyzN68Qosn15ttRys6k6oBZ0abccSaEx8D4wUz2Iq0FH1dssUEQUC5E0G2xecFaY3GqvCHR6S+/5n07opA3Hse45RNYrkEuq15VZgToYnizqDgTo8cMFUkEjnpqC8FNzZeo9N5a/4rr4GbtEHIl4iy6huKslPdj45WxGps+p5JD7Ym5MAufceUnjbIcNjZX3thkR/uXkGIYauPU08f0jMuABdrEQJZ0DFFwAKAdOZrjVnTF0viBN6h0cZYsKiVhIB8YrbJ8QJy4j3teb+5ODZLHQ/JAffVTY6EmZoOuxk65+ALBOmak8zOwkoIOl3GpC6QoXCUNVPoH+EmXbJt1v4/HheqgFuqovw0jhVW+thjrFD4olhhiSmD03e62x2pvD/1uIkamgX5UCkcfV2PcunNzvC//3RJKN008mgeXhHMEvlGNDzXLR3yZ3M4nEOlkOcVmfB5iGOuX/8Xye3w3Z8pu2nOVFEJUnzpno6;4:ckVKGT4FnB+Jhvo9CPyhGjfIM8ZyY8OeZog/TaMV9iKWoGKYKQKP7FQkXqt0tcow+FxWUjd6hdfB6jQt1AgKg5GzOACmmWxKl0Om1sLggr59zI4xBGzg/xBpFUtmKqEhUO0BwQ/FYQNyedEwRr6COxmrL47QNcQExRAz7YeJNtXO+MnewuulV8dzI0j2va/uDKoMl70g/qu5EM23qiTcl0lzppe25qpNwzanlsS+VCDUjTHAkHK23MRgbNgANVhKrRcImrps2OgXS6/HwKrj2RlwkApnw0JHomM4PjcFGU+7Ajw3qJr/ligvmxLidvz3GKcVEp/umerrZEwZmeYQsd8DV62Ui9h6ZUtAph08vIEjLNpZ/dcnh9T9FuQVD3fv
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077FF98CEEEBAEA6A2CB49EBEB70@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(11241501184)(944501327)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(52116002)(16526019)(93886005)(54906003)(476003)(2906002)(8936002)(8676002)(316002)(6916009)(6666003)(81156014)(81166006)(486006)(16586007)(6506007)(50466002)(86362001)(11346002)(76176011)(58126008)(386003)(446003)(7696005)(5660300001)(186003)(46003)(106356001)(305945005)(4326008)(105586002)(55016002)(7736002)(39060400002)(25786009)(23726003)(6246003)(53936002)(47776003)(9686003)(53546011)(68736007)(52396003)(478600001)(229853002)(97736004)(33656002)(1076002)(6116002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:XWKFtgIM7xM/sQA20v4NMYJgXrSivx9E+DUvuJ+E8?=
 =?us-ascii?Q?W3q46WN/HmrZ9T+rhReH6ICmCLHT5gcdghRu6aht9hMynrD9Cs2kWZRz6yOb?=
 =?us-ascii?Q?F5qvfMGpBZkVbIBI/TYVeazh1hstOlkzkCzs4g0g/AWGU0Vej4mHOeap2AbU?=
 =?us-ascii?Q?LMZ73GH0GhBNwOTcy0s2rvI/LQIAFkZprIGpOZLzvYYxEA2KJ//sIpGwDauC?=
 =?us-ascii?Q?1/bU6u6wleA8B4SOFYigBi2lgJ/bwFPxi+K5I2S44fBNmL8zB4uoTqTFRcLN?=
 =?us-ascii?Q?iZ5/PUB4KmpOuklLmEz7Y47Eysny61yYmtiNu0blAY7mcfn6bg/b+CKknuHp?=
 =?us-ascii?Q?KAovzHeF9c3KehiG2sX3RQO2uz1ZpOvwLIZ+il7dO+OejkRwczu+7sAZalPj?=
 =?us-ascii?Q?ylEkTJ8HuI5+7f0Yd6FsIw4dJGZHP0Qd83gyLE/TiUw+SWzmpw8HVlwSQIRs?=
 =?us-ascii?Q?OLFkMz0hzIWTV2gV4Cs+CnkkyvxMM7W3nJGeyYxP61kDE1xRAlKwLj7LKlXP?=
 =?us-ascii?Q?HG39/Kfp3HkWgYGiuTkBpqpQucT0t2V+oOF/DBpqJzN/7gdoGXrT+ppbvsuk?=
 =?us-ascii?Q?731mtD5eszBfAPzzKwpnES9meGWitGDd0vW/r5tZ0H1/Y9a84drGHTtScbjQ?=
 =?us-ascii?Q?YViZroKEh7qWKOKKN/VsBNCH75lIoQgkOwQ2/iEsM44AlL2Uh4eHtTtQQzrb?=
 =?us-ascii?Q?sRul6ygydH5Ng4c6LSm53oj338vaWssKxlUstFd/fnwZHpDrwCS9WhUIPdjt?=
 =?us-ascii?Q?BKiLsSlxlaJN4D1I6XFGQJFsJrGm3TfRmCIYFgcaT/Lpd3sw3LEhVWzoKFSq?=
 =?us-ascii?Q?Q0f51zUZxeYrItGRGXQW3PHvlb8qshdSozwT6gjzqIW9Cmsew/Kqjn+cutfu?=
 =?us-ascii?Q?9YnXm/FE+E829bZq2QV84z+U3YKDGXUQ8mhCMapYmd2+xwinuasYv0w8BXMO?=
 =?us-ascii?Q?OWbic8GvtbDdUXLC68Q3VML1eKelzj9/kwx+EqP9HWYpfofX4EGnywwxpPzU?=
 =?us-ascii?Q?Z/ldgYhbprx+xfopfOJow07KMP/V9NnJpEOz6mCEcOWYQk9n1yruG5GA4wjn?=
 =?us-ascii?Q?Luccs0hv6iLEPs8iwAdtcq5cwJc/Yb1IOmbhGchyQl+y2q5tXBjfVzYfNOys?=
 =?us-ascii?Q?NJA6PNYgO+PQ7LyoiXDUBOz/MrNl1gTF/U0cygy0mQ9xgjuBptOM3bRqrhkF?=
 =?us-ascii?Q?i8HIXhjEKv9Gu6d/XO96hrd4VirZ5+qtxwn+PnpU2A/LVeVBe0HanCCi6sZJ?=
 =?us-ascii?Q?Xo3gWdPdhw6cm7qEWpw5xg/njmHmoXr03JVjcfB51+WdZOnUFsftxC3d5z1F?=
 =?us-ascii?Q?4qFHb0bnC+cGA8OeEf4haY=3D?=
X-Microsoft-Antispam-Message-Info: b2L8NxPXSvjLpb+RikEezBd45CC9pD27r1g3L80AXMfY9iA2cF79agOymi2dZXVWxkxObgE1R4n7msHmuB/cKUzy+qcCIGqXjnH+u5fVO6crS4fm9u1UrO0FFJnEU3pfGrxQEaLP+qmLEEYMVULEZojGxInD/qp2nvc8Ung1KVpCWhvhwCfyW7jqK+GGl5wP
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:/6aQ7FG3ttaqTPk2VNUkkxoixQW62KdBhUfBQ6LtWR6XcmM4YGai8sSaGkd85UV7KA0oHbzNsMrzJyYlRVETWJMHU4BIIbSLbnuCor78dnxLBCa+CTZgL8ClA6cUGNslVR42iL35YcqHkUFoIPjSD5BjlnBFu12EkWd3W6TffQQEirJjUd9GjYOl25hRJqzgK/NMnik/DKDUHjwFeqYC6UzUYnJMgqqeMnICowDmQ27w68ICSm5hPlq9+0bhGg8mIoKTHEo1DBiFksNupphPZEOWYMCAt2qnR6FG83w13Nv+lhXURkTD3MZOp8yeMGQu+Qp6yj9jhxwAZYdrLjgXxQHLmJmKbAlyKp9v+XRt6CSFCcO4GmMABNEtyGsG7qU1J6XOkyEJk7aNfNjOkUDt0hj1DSi2EA6S+eMsw+qrr5qpn+fgS45TlqoJPJefVvjxV9s2Wdq1FRbV2lvd9xHeAQ==;5:fbtVUn5k2ajpXzOAziMSDJ0Hu8ciQ9n46nBBYWhsIiG9xZ04HvIOv8fukZZex8xZrIxQZIa/veg1Wc0KlBBUKgV+OQdLziEXBqUk4hevjQexkpXwvmIXCzoT9FSKZ89VSWruwM+XmVcSlB/Pcbk4qB3TSXpEondnJsZOnCd/nI0=;24:5FFSF7ZzBqyrpC2+MZV/Bx6Q3COLtNJ4Hc5JeNK6rJWzOWR/QUj73rJeWx3ytgCuvCgEDxCCAgvoCMb2b5CkR0AvUeolEUTQIq6wTK8hDZA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:x0f8fnNO+v04EUIaTZwkkWB8SeY5Wtb/xPTII8e+4P55w4oEiDP0yuQBeJKA3VnSu80L77oIhsp1CzcKe5QyaH6qdgW+qdCazJMGdjfdtvqgeEpnnW1PL/yAIj3hiMqJwCPNw1D4fioicWCc43H7fNYL4I2Uw75YHOcYDQIKBlCLWusdVzSUrAqheeO0EmL5xq2gv76GmYU+6cgjyb2ib/cY7/2HPmfcrGwUMD6heSWTjmpyYmRJxwtIbVR3wdF1;20:ExWn3TLoc7yio+AEJm9XsEvulQUwXAOswqvYnXKcMsvsVZ06uTpWNJkpyreJzxNcuCbCIhuyKtq8HkAWxW6VqkKoWYm9L8PsteAOKKW/R1IF+TgmHQip56+KSgnE6mNanG36KIoyG0IZuXdf0rgivjlx11KT1z7udwcgnPP3Zy4=
X-MS-Office365-Filtering-Correlation-Id: 04a0efe6-73be-4e1c-4f58-08d5a4959960
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 19:01:10.2318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a0efe6-73be-4e1c-4f58-08d5a4959960
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew!

Can you, please, pull this patchset?

Thanks!

Roman

On Fri, Apr 06, 2018 at 12:38:02PM -0400, Johannes Weiner wrote:
> On Fri, Apr 06, 2018 at 01:21:38PM +0100, Roman Gushchin wrote:
> >
> > From 466c35c36cae392cfee5e54a2884792972e789ee Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Thu, 5 Apr 2018 19:31:35 +0100
> > Subject: [PATCH v4 3/4] mm: treat memory.low value inclusive
> > 
> > If memcg's usage is equal to the memory.low value, avoid reclaiming
> > from this cgroup while there is a surplus of reclaimable memory.
> > 
> > This sounds more logical and also matches memory.high and memory.max
> > behavior: both are inclusive.
> > 
> > Empty cgroups are not considered protected, so MEMCG_LOW events
> > are not emitted for empty cgroups, if there is no more reclaimable
> > memory in the system.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: kernel-team@fb.com
> > Cc: linux-mm@kvack.org
> > Cc: cgroups@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> 
> Looks good, thanks!
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
