Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeCEP4L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:56:11 -0500
Received: from mail-eopbgr40104.outbound.protection.outlook.com ([40.107.4.104]:3160
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752401AbeCEP4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:56:03 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 2/2] i2c: mux: pca954x: verify the device id of the
 pca984x chips
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-3-peda@axentia.se>
 <20180305155303.i4zut6wtwckdes7z@ninjato>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <eb97edc2-3a16-2931-2f19-a80a5ab4d88b@axentia.se>
Date: Mon, 5 Mar 2018 16:55:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305155303.i4zut6wtwckdes7z@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::16) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72300e20-2b70-446e-07b8-08d582b1976d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:FGaOFSEEh+2miYb9dzgcrIa4NDl5/wUM6DE1ZzQDQmGMaHkr/qslor30VCtrksNQL4Tpm0IN8tFJI1vUTccgfVlOQM40Rmu5D+L5Z21ebJyn9lsnh1hHfPvxCdPv/wfpHLw7sGBIIOl5KJQQCIuv3WJsThEudF64MOl1b6DmzIIjqJ6/4sZLCpsc8u6feKCgJry8hMLig5KUXEikGmCBz39fQFlhNM6n84GrdDa3Zty2JHXV9YA8O4WloOz+Dd4g;25:pzTZiOiYi2tYXcrMgO2AgK0X2Cm7yTsraMA+sgg/pTkyyKYjEHdnAzCSzNQT9yu0T/ICEH285Q1Tl5FBFzHtZX9ZNp2uppGn0lszhzkz99d3SwhIPkdOtVV3qrU67Jrqr6KIqet9hlsEKaKrHxkSO3KtgmFRfp1LUVKDrSDfk2i5Zp57FoaJ+P0gOhn4bXy3k8cigPO05gdX4nSZMgIvXrEIgqo7oq//L3Gcnm2qA76obGvQT1cNMn9jQd41hKLOQlQsJyggiDm/3emEpM+P0RUc+ykkDym1YPRQLPJOERhun1ijHeRqsBkdjZ0ErWRzs/p9mu7RcoDg+cWLzi8t/Q==;31:6tAAs484mvO1xx3oWFNtsYxxdHweeD/O8dycqiszpS579iE7suRurpFBdrvL8G+kxgDax6vbqLw8mwIMWZ1rxVwiDOdOg7IBm2U5ZyJZ6dlaL3+5UgNB3Tjb8/r84mQNuwFGoJBfbjavRoIwe0B4OMOFAp6lL8ouQ6suarvxzca92AAmnWnqshEV0tg0bEQlahF4+KDrHDMKoovpZVnszt/AWcTn80uiBRfyk2B0uio=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;20:SY70gIo2FGqCjSRqlFTv2nPHPx1TgMDQ6b3m0FUOliC6NUHXE66bKHoRd1SI+Yj1b6FZUfB9m6Dsbe0rixWDWYdCVkdTFXSoIs9GJb+EoeOIep5n5W8c1QYaqz5HWfFAhMPCH6JnLS4pXwdOt+zV6Gkj9ISj8Umnr+fElJ9326o=;4:t8RNaYppUWrXNnjxHFinyyMQWApEFCgcoqHszsDWFWUOWyp0bnIZt4M2duiuXZdo2oQwlY1rrcTznykpwwMSkYPp9gOly2PVo4f8YjLCqmqtK9dtdcEURzGvfFbEWGFzpxbJ0Tn2j3fA8RYyn2nN0ndhan9hDx+ryzCIUaL0XhgrJ6bMq4ojoPR8QpyOUQbK4S2z38qviQbnsz+lkgB3KXdUdoJ+Yh3EZnx4Jfybn0STaz4NscEblYvzLL8zLgNu28ljVeEQYQjQqqZkBSOlog==
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277949B70704F3A58DF0162FBCDA0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(346002)(376002)(396003)(39830400003)(377424004)(189003)(199004)(5660300001)(97736004)(36756003)(117156002)(6116002)(64126003)(58126008)(6486002)(31696002)(81166006)(4326008)(81156014)(8936002)(76176011)(8676002)(50466002)(53936002)(52116002)(105586002)(36916002)(230700001)(3260700006)(25786009)(3846002)(65806001)(65956001)(66066001)(386003)(26005)(77096007)(186003)(53546011)(7736002)(305945005)(229853002)(2950100002)(6916009)(106356001)(6666003)(47776003)(16526019)(2906002)(23746002)(316002)(68736007)(16576012)(65826007)(31686004)(86362001)(6246003)(74482002)(478600001)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;HE1PR0202MB2779;23:xWzK9MQKOMF1ys079Ym18Xfs7EAK3CfvU6z?=
 =?Windows-1252?Q?m7HSjlGNnaXhnqba53XaKutI6/Xrxyl0nv9UjRAT2E9iqeZ046lYjt4U?=
 =?Windows-1252?Q?p4kfR4xGU78o2geujQ62csdE7Be2ghUHayvvunJdN/doYxaUS9tb7r3g?=
 =?Windows-1252?Q?twn3vjCbvV+wMBHbiudRrASfg+6/cHF6VHQe6JmC2DQ/VfxeTl741eIb?=
 =?Windows-1252?Q?uQO8OP3T+4sHa/SUoyWbkbbwCqCw3JJNKZwNJsdx1MGgg3iJxJp60aZs?=
 =?Windows-1252?Q?TNUT7F05adCLWej1wymsZsYFpDz9fcJ0gc8kNcWXiAra7feT4lzkagve?=
 =?Windows-1252?Q?MCJQCo9Lr7Q4qazlMWfLpS7yNc/YRvnexPTtIXEyUc5w2J5Plem6n50L?=
 =?Windows-1252?Q?EqKYwBIhGxH46BlOHI28zxg4xHNuaVNnVss/lMpUg6zK2iyq4V0rKjHY?=
 =?Windows-1252?Q?qmIcURKHPNOmt7PRmRh5Q/Qo19lAJgDzvHZ1x1the4MI6XvBvUhRLjLQ?=
 =?Windows-1252?Q?+vLW/P2n1UKttDBI0RQJyVlDCwfR2sFw2ViJml1Q3tawp1B8nd/1URpJ?=
 =?Windows-1252?Q?co2Hc23WcfNxsM9ZD41uOG6rUhCw0x6BWQzNChpfX2Zr+lYwYDr5hrht?=
 =?Windows-1252?Q?9XrQnPLFdsw5YAjuNsuphPjdh+HNVGAsVEkC/meN0rgvbtQSLCk7iN+3?=
 =?Windows-1252?Q?J2b7BQHkyViadcfQs6SHGka/vNxUTPBsPsEy/yK4qhtE5E4S6MTwqv1Q?=
 =?Windows-1252?Q?L+LC6mXNhEWXcI78yhNSkxcce9RVODj9g9K/28DUW0T8UVzfXfWgTL4y?=
 =?Windows-1252?Q?tMpaufvzTfVl8IEH4akuh6hhaKrTfP7YeXVktZeHCq7QUdjcbZHDufhy?=
 =?Windows-1252?Q?o0QV/NcjzdqoeVb7bBvsfigVccF+g33TeX8Wu96xA0xG3NPcg8LckYbp?=
 =?Windows-1252?Q?ymgYFJ/wUKaIP5U9TFewdFCXaqAbeciNoxoQp6CPq5Ktah/LfOG8nns4?=
 =?Windows-1252?Q?4HqlWMiL+xl1IaxN9hhMxATzB3lfP7Gs7g3lLV77oqLHqBcPszI9cItM?=
 =?Windows-1252?Q?LdgsHQTX//xzcazgm6DFHlJazzDTGshXI74OTjlV/wcQp7SvlSsGrbBG?=
 =?Windows-1252?Q?e9O4T4vHuYozh7GJUts2bTJ3U4j4xk8nprQHaWJC+D7B9F2I8uxKdrpM?=
 =?Windows-1252?Q?Khze0UNLBw3wRdvPQkZ9OAeTvjkNZGxC1D7nptT3tKLFHetdMuARfHJk?=
 =?Windows-1252?Q?vHr9RWArTKTt5abwMNwoBgUGfKm+NeZPX/dzLEHEdgSEwEeXF7mmEIXA?=
 =?Windows-1252?Q?r3Ad1YgjFOYFxPJEJ6dC3j34kpZKsupBE/SAnZHANqY2CDTrTqkBy4rE?=
 =?Windows-1252?Q?oCUh9l1vvm5O2CoMZVVz+vjfkb1+lUAwCWRejTopvgIJrk+WXw8qdKwn?=
 =?Windows-1252?Q?mo/MMe4zaX1zvaQNBswfaV1fo7VBs5I7gcUDE7HLvGe0uoBKO/+uir7H?=
 =?Windows-1252?Q?sPTYxdn8y0NShjoC2TarXu7mjID1kKb/oZIlWNQCuzb3kLuEM0zu17zH?=
 =?Windows-1252?Q?z7J9dKf/3VSbUUeU=3D?=
X-Microsoft-Antispam-Message-Info: lRr2piSIccTd2d13e29leJ9iACDqRNTbhACP9jPZwSZxUefJuIxmCOeaYEdlqyUL0aMHgv/cGLafkUpRVy3oZBrkQfKW0+8dV0wtDCLNWsUcM9xe0HrxL3T71glBBgsOpcRLYFxwGIJSQ+AohWU15/pqGfkOXDcWz/tboqG/afjK69VVkf4VBHjK593TCKpw
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:9feCGTzg+HSFP7c2vBIsrnl85bwkV7vcAC+SLe4L67FYgya94I0rg8t7CgIAr4cboHZNvRz2KT3XJdmYbGPdaT4yafQ/mtnd87bJjjuJ62dpSx7GMY3R63ok2DoMagKQTeXrMsr18+J0AXGUbRC8oAdgCo14yVfZSJndvC+I9Rhbp8PDEs4wVFZBTcBA7BznrjtJs/K8XIVC5Z9KpG606Xc9BN3+m/p4+cKfBQ2vG4r0yFVHGMaK8vd8qQmXryPjqeuxXp77ykvkJV8lWCv4mhItS4ZckkcqwWBttJSFF6WX+SH5Q5njsHT1IB40h8/pCWxx04tDTHAr92tG+Dy10yEpChItu4ZKHL+yKW5CFf4=;5:3pgckU+xfiAHC17FX4GQtgZJxz7TT5RPEQPLU+IVhhOp13fng/AbElrTvGIGT002yWgtry5Rs/l5BBp50llByca0ZE4AUHXQSFQyv9bGAf6Qda++vbuMIRDnTj9E9FikIqA71cVkl+VxV/5CPSXdVbc1dzFd1XUadsyxydZjGl8=;24:3tuKwYy4ro7NP47BvLpov6F0bI3TtE7pM2U2pUJi1SmGcGMFUw5BMvMYWL69ckjX+7NbqAytvx63KNJfMl8sQkbuJDLTkRfS3Kw/Kk6EBXY=;7:9+kt5sqiNFHXKuLRvfISBrQzz9El3bRdoOK33d9b4sB1DXYEED/gy2xuPEtdZJ0/BoFTcEzig09dHgl4a8tNuRkXAQMLx7V34KwgBWO6z4PPfn6zP/6zbyLHybnP+Zxm8dTY/AL3mDyV0ZwstLxLyY37kjc4qSMtJSYFGZJtjf3318ZHfDpzOVni/wtpmR5LyS39RSdlgeZTjcnKzqCp6pqSfLZqBNNPjz2pNAYFuafxLWDrJ6BgHzM44zpMsuiF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 15:56:00.2557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72300e20-2b70-446e-07b8-08d582b1976d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-05 16:53, Wolfram Sang wrote:
> 
>> @@ -97,59 +98,83 @@ static const struct chip_desc chips[] = {
>>  		.nchans = 2,
>>  		.enable = 0x4,
>>  		.muxtype = pca954x_ismux,
>> +		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
> 
> Can't we just leave this empty and add a NULL pointer check below when
> testing for the device id?

Nope, it's not a pointer. I didn't think it should be, but maybe it
should? The drawback is that you have to create an extra variable
for each of the chips that do need an id, and I didn't fancy that...

Cheers,
Peter
