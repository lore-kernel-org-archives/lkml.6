Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6451214EE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ROyVIfbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6451214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeHNVGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:06:35 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:14571
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbeHNVGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/tST9klWTyvAB2I5SbKgboKN1rz7PW4SwByYU8i1Io=;
 b=ROyVIfbElcSL9uPKiE7Bwhoc98SY/NbR8MP+p9G25l373pzyjXHTRE5cLSYJI2vTgeS42VCCmxvYpYIKwCQwjGUZ7ILvOWQ7ZtmG1ngw3jlqgAWx5WrK5dlZ4PcildvhW1o0uSSBj+xpxPRQLDWjQhe5CQJtzixyVXfGT9tocmU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=petrm@mellanox.com; 
Received: from dev-r-vrt-156.mtr.labs.mlnx (37.142.13.130) by
 VI1PR05MB4192.eurprd05.prod.outlook.com (2603:10a6:803:4e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Tue, 14 Aug 2018 18:18:05 +0000
From:   Petr Machata <petrm@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, jiri@mellanox.com,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT] net: dsa: Allow configuring CPU port VLANs
References: <20180624153339.13572-1-f.fainelli@gmail.com>
        <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx>
        <20180625091713.GA13442@apalos>
        <9ce291a4-b40d-81d8-1c1a-c4311e5cc113@gmail.com>
Date:   Tue, 14 Aug 2018 21:17:38 +0300
In-Reply-To: <9ce291a4-b40d-81d8-1c1a-c4311e5cc113@gmail.com> (Florian
        Fainelli's message of "Fri, 10 Aug 2018 16:58:10 -0700")
Message-ID: <wihva8csth9.fsf@dev-r-vrt-156.mtr.labs.mlnx>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: AM0PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::25) To VI1PR05MB4192.eurprd05.prod.outlook.com
 (2603:10a6:803:4e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696bbac8-25f5-4308-07a6-08d6021248bd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4192;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4192;3:ffU/0IMRAnKwTLQAQOMr7Z05fMzp7N0srJofcwtqiiGpatP5usZkDox19fHCQuWS8QsXHDB5kl4tWigCFmHUy8qJdchj92bvUO3Gb3QqSmzaOQqoG1C9QTpqxyTTas8u3042Nek+l/feVF4YnywUHjcImXdoZxCer6RFQrfJ8ec9aFt6N0J3MkgojU+tFFTVWZXH+PddcIYz9qY8ph6fyxvdr8lzL5lt8IttiVcfFv+Q7XHpKi785hCSQhMX3qlB;25:a9Mr4sXZAfR4mx9AbeZZJa/EjdGTIT8tRGZ+hG7TiWx/cHCT1RrLkeIkQJAYpVSeZHKg6KMYeNLxk3fohASsz8rkinA3IhV7Fq62kxx87dkSun2l+Wgex/XIwkm0KP9koLQX0d31gzhillabJUyR+y30m//jauXLst/vTkuCutqRwYcqzP5KoIpv92UQn8B/sqBgop0T4i75kilk7pJfKBDBAAY9IaLvoayqAz8akxYF97KYXiP9Wn/0A3u2nFgJlrZzKVdU0jZBQdm7843xRM/y6iKT0Eg77d7A/dvE6SnFh9+XFJJoyi7IbdcgUVn6SELjGXJMJzu/M671xUOMjw==;31:2rPd6c+lDF1HxdcGl0gOCIR+COiMTWSnJGZTyitNAgGnnHGYEa63lv3gRyLhVAEHmjB3ZqQnqwAkCFwBMhyN33BbTUhAxqu9oV0ktZHzwj+HgsbGI6FG/VsszwS1D6BB1YKja9ZBM+wk7bMRYAVe2Qa+VuK00TVyolBfdQkXq2IFOJ+3G1seruTm1PlaUy96VPLXD2awGPYLMkfoYiqRksNDILe1OjI119uoehcEF8s=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4192:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4192;20:3pvO9Rq1thcaPC6nSbQ9Wd4umSVU37eAIKsqvH8Ocogn7BCX1zkHs18njoTiknvCGJ1Gjqlq01qdmVj+kvsaK17h/G2WdMAfHbun9H0ojZETfzKlHZYt6iogy41nnBMozmtVj9cIo73wp+5T34kw7z401JY8Gl0inHX9Htj0GYlnuVsICB05x8+qq/AjpkjQ/0bCifPW+JFBb3c8owEBmsg3mE9hr/fFr4kv5Q07IJpxIB3KVijja8dDBF8Hhoi0C6kHI22unyt5HS458V9lbkyCC/nfK1k/E+YuCdiGriqc8XItzodOqTDeGnw7S+ZfSMK2oKX8DLObnywihp3g0o1Q7ryF884sj0+nePzAwW7zL8ocCLjSonZCOSbdOA9FoRxs+UMsvw3gpssvORotgAA1yuuFste9VJJh3Ml+fENWjImAd2NGDUBJd3h6flrs4IMk6HvcCSu4gTc92zJXOEs/W6uAGBqfR7NknZavYCJkMgYvcJxjISSQKYqEJqbk;4:z5oEEXPrzV0qimS6HYetgpVY6RnUwaMO8Ogycme9r2BaziH+pjo35x147CxGKIMBkp/45D2X3rJkZlmf9i7Y3mBsa5VbZm4U9fKnYpf8JJBs9BKV/DX2krxxK8nYPow5HFPadiCtxOe45nYT1Sf4ypGQhvKaRhgGA+0sJkgl4/p4wEAW87FdZFDi56pZForraq4maqv/7iq5pwFhpAu9MN/iL3Z0OBSQ/9ueJY4ieY4BTt5UKjlOPinKGn65r70oLe/AdGDGqB+6frFRA/yWAwj/m1ZB5PAkWk8sTzGSFDaNWzuNMhaiKLBFfyyJjiy/
X-Microsoft-Antispam-PRVS: <VI1PR05MB419253849433CC93B79988D3DB380@VI1PR05MB4192.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4192;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4192;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(52314003)(11346002)(446003)(16586007)(3846002)(6116002)(55016002)(956004)(105586002)(6666003)(229853002)(53936002)(4326008)(5024004)(39060400002)(58126008)(6916009)(26005)(476003)(106356001)(2906002)(6246003)(486006)(8936002)(9686003)(48376002)(54906003)(25786009)(53546011)(305945005)(93886005)(47776003)(8676002)(52116002)(7736002)(478600001)(6506007)(76176011)(81156014)(386003)(51416003)(66066001)(7696005)(50466002)(86362001)(316002)(16526019)(68736007)(81166006)(5660300001)(97736004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4192;H:dev-r-vrt-156.mtr.labs.mlnx;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4192;23:DuFJ9SFDzsGNGHs4umzuQr2zSARM9D0dGYcvoAn0+?=
 =?us-ascii?Q?dGEwGc8K5suAgg4CcNpM+M2W4qLpLl1hj2yBztELGvZJGcRnXv7mNh2ZCBYG?=
 =?us-ascii?Q?P64e2QRNhDBK67UpbZ/Se/HWRFjMPS/MFq6Nvd498m9j7CfK0KkH7vLo2Huq?=
 =?us-ascii?Q?9mPLJdEs/ipM1Dn0o4aK03BGr3qkxU/bfZtTjJUfGatuqEL7MXZbNptWHuvs?=
 =?us-ascii?Q?qT+yi971BXFB3Ufq7Ip2KVvb2rIeHHknE04XMlTFRhA8wunMsyoyzQ1OIh02?=
 =?us-ascii?Q?Tohln7LsUdlBRhlofNb0Fs3MMDooUsM75Jj76+mA5YbA1CBr0DdHyPBWdku6?=
 =?us-ascii?Q?KDWLB+ROFDqgysJ2gcb2R+ylT+iCaLjbP5mUgz1UlbUcG8+/iCu2anhXQ4ve?=
 =?us-ascii?Q?aBppuLv4+a5XGhv+34JrbQ5O9W4fqqJiRdmHhm3Mx8VkTqopABm6X9/tQdlH?=
 =?us-ascii?Q?hn7jJVJNaoQhDK4ZrYAos5c33vcz5i/5gyn74wLCwaM37zSqZURe3T4Qh/3n?=
 =?us-ascii?Q?SfFxPu0JFbe/eieQNCRvzp/cm0aG9ZayqjRAJ6VfxHv+i1mhrQaRIfRdVRYs?=
 =?us-ascii?Q?+MtEFGrDPnNKXd99SNR4V9DyMXobdke9Awwq0b/eUUE9KKMwS+mo8CczdmZJ?=
 =?us-ascii?Q?eCfSquU7EQdu7MpUsT2BMzSb4TDGALUr4+HajV7tnZUqcWUHNlD7QApMeq4f?=
 =?us-ascii?Q?9TseobyN01UmAu346o6elUwqxE7h1t3u64mFnAC43sYIS8+ZXNjqvidbOEgm?=
 =?us-ascii?Q?0faV+6dfBAUHIdUQh8sncGlB6pzJzYOhaSYTalQ2QB/pkcbdBFSy+9zdv65y?=
 =?us-ascii?Q?g77kyAhWIWX1+rUKmC0DoehWSJ1y5tNWMW2W5xgZr63uZuJ7AeLJ84n24qiU?=
 =?us-ascii?Q?rpl9+pIc4aKzbNQ9bEAjTw+E1JL4RGTi3+Ovg2tAQfvc/MyGkrmqOHhGZ1KU?=
 =?us-ascii?Q?m1Uvzy4fIcJJHTbNZ4p03E0s6arj3NCU44qkxuFQyeL36tNyvKAF8ewnMExB?=
 =?us-ascii?Q?UjtJgLzPCQkGFdBNr7u0ozD38AzlFbnRBCvWM+nKUDy8NHtlejXkjGXRsjsC?=
 =?us-ascii?Q?QjE+O3BERceNEg2Po3ErgJ2c0QOTkD/kXgblQBGQDL0KMHV8QkRSUTNgjKv9?=
 =?us-ascii?Q?izQxk1PY5SecPRpIL8OsuTqa3vQ8rf+bDAJ0CjUaQO8ZBoCXkb7vzNQSouVe?=
 =?us-ascii?Q?GHMu8IgbD5AAMP5vJ6Mjy2KKbgZVh92mizGGsa/CtIFrL3OqqFqZyUOOb9T5?=
 =?us-ascii?Q?9v+i0+7bCz7OO1HchQZY0vpBttFQLsQwlIr92bijmgbIvaZIuYusVQJMz4O2?=
 =?us-ascii?Q?4iJb+UkuiVorBzVJDzAbzY=3D?=
X-Microsoft-Antispam-Message-Info: nu6nbOy1PxtYTT6apDv6j1zyl0Z0AEWZVohuW9z5pE+5kC1UnIXZt41D9Fb5Y7DkH5+07oQ5GgHgamUHcZZRodbGmdSmyQijipo9q5K68abeg+KolTEbPHSB4KO5S7TbP8l6JD/4tlgXSRazAibnn5IBaiWZd6loalkz+PqCnqDAxmDBalqcmQlLH/aam9zhZRwKVq1KN8K6Hdw1bbW63bpB5hrbRfR6lKDsGvFb2ZFUxF62G+pvmDQKg6E3kb+qSap+gC1hDiON7zBJDCBjaBkeyPXYzHIPnsvSZG/bH/yJGR2WXU5Eik7PQoVwnFlHOjwbmQoiAQTHxxfKQmnh7KaNM1gt7P4XnGRbiCbYgX0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4192;6:UZe3OEXh8d/r5XuomDOeKIYuXGr0B0+ssRK2b8CobhyhDOB9yQynp2YblOyKmDzGpuFBqy1QqjWD8PDsORmjX7nHZJ7oIO1lvHw8OV6k6yUtsQOIhkHCwNAfBVcT+hYVdG22wQ3PL8DQ7NaTsY8Ar97PfDhV4ycnu2sI7sjeaBLkxzMdj4kM4hRUjiSBIow67gj4id2aHK6vdMUo+uyfwJYAg0s1BuIRiuVHBIFwm9PvVPP3owysWFKpuJrxMLO9xS214bcr+fMtvQCAo3Xv//FCm/ceET0104+XQT/tYDs3cpeiUpj5I98H+jVUO3+pTGHccHk49a8neq4AvvMR9Z1LyKXnwhIjr+8BI5nzUC5L3uKp+s/yoYoNnIqT39GDXmk+BSZcHg0Mw24twsYLbc4JwxvssOaLHSHZpxt9JUClhBzmHjUFu0BdSeVl1TQoFoJ27IkoAtqWIxA+PhQkAg==;5:y4J71D3VcO1Tf1nasb/ioQjvVFYm+30uXkxgaKu/p06dRLb+ZoEKx3WcY22rz3/XzCf5s0AHEsh2D6z65QKl4Gvj5OjGZQ8CEylf8DvcgYSSgnLAY5eZ6EoyLS0QhQMcvlZE742jVo89FOiMo7+OBSctjrDzaiqdN4hNzGmNkM8=;7:8az802zS7Kti7kLShtc3mI6HpX+flxHKDZcR5Ontlk1iSugSGIN0WxJHnKocyx1uwVQJ4rHAA6ufABfWaTM2HBJB5L9AeOX9dQ29wCs34ysOBk33zaBt/8appDqSzU6mvvjnMH9PcFCN2s/cM4QHvTacgjlbJ1IyoPdBCEPCvUiMjPQT4mnQlyzUm0Js76nGp6STGZ46RLPhxtlEZ1xSvOKKLaXW30h3qIekAKOf5AJZ33rsAGpOeE+Pw/x6uXyl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 18:18:05.8143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bbac8-25f5-4308-07a6-08d6021248bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 06/25/2018 02:17 AM, Ilias Apalodimas wrote:
>> On Mon, Jun 25, 2018 at 12:13:10PM +0300, Petr Machata wrote:
>>> Florian Fainelli <f.fainelli@gmail.com> writes:
>>>
>>>>  	if (netif_is_bridge_master(vlan->obj.orig_dev))
>>>> -		return -EOPNOTSUPP;
>>>> +		info.port = dp->cpu_dp->index;
>>>
>>> The condition above will trigger also when a VLAN is added on a member
>>> port, and there's no other port with that VLAN. In that case the VLAN
>>> comes without the BRIDGE_VLAN_INFO_BRENTRY flag. In mlxsw we have this
>>> to get the bridge VLANs:
>>>
>>> 	if (netif_is_bridge_master(orig_dev)) {
>>> 		[...]
>>> 		if ((vlan->flags & BRIDGE_VLAN_INFO_BRENTRY) &&
>>> 		[...]
>>>
>>> This doesn't appear to be done in DSA unless I'm missing something.
>> Petr's right. This will trigger for VLANs added on 'not cpu ports' if the VLAN
>> is not already a member. 
>> 
>> This command has BRIDGE_VLAN_INFO_BRENTRY set:
>> bridge vlan add dev br0 vid 100 pvid untagged self 
>> I had the same issue on my CPSW RFC and solved it
>> exactly the same was as Petr suggested.
>
> Humm, there must be something obvious I am missing, but the following
> don't exactly result in what I would expect after adding a check for
> vlan->flags & BRIDGE_VLAN_INFO_BRENTRY:
>
> brctl addbr br0
> echo 1 > /sys/class/net/br0/bridge/vlan_filtering
> brctl addif br0 lan1

From what I see, the CPU port is configured with VLAN 1 as soon as the
bridge is created:

# brctl addbr br
# bridge v sh dev br
port    vlan ids
br       1 PVID Egress Untagged

I expect there are events for this (but I didn't check), but the driver
won't see them, because it doesn't have any ports attached to the bridge
yet.

> #1 results in lan1 being programmed with VID 1, PVID, untagged, but not
> the CPU port. I would have sort of expected that the bridge layer would
> also push the configuration to br0/CPU port since this is the default VLAN:
>
> bridge vlan show dev br0
> port	vlan ids
> br0	1 PVID Egress Untagged

OK, apparently we are talking past each other. When you say "CPU port",
is "br0" not what you have in mind? Because I see 1 configured at br0 in
your listings.

> bridge vlan add vid 2 dev lan1
>
> #2 same thing, results in only lan1 being programmed with VID 2, tagged
> but that is expected because we are creating the VLAN only for the
> user-facing port.
>
> bridge vlan add vid 3 dev br0 self
>
> #3 results in the CPU port being programmed with VID 3, tagged, again,
> this is expected because we are only programming the bridge master/CPU
> port here.
>
> Does #1 also happen for cpsw and mlxsw or do you actually get events
> about the bridge's default VLAN configuration? Or does the switch driver
> actually need to obtain that at the time the port is enslaved somehow?

I don't think we care about the CPU port in mlxsw. If the packet matches
one of the local MACs, it gets trapped anyway, so all this stuff is then
handled in slow path.

Petr
