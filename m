Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeDYMj4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:39:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38488 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751525AbeDYMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:39:54 -0400
Date: Wed, 25 Apr 2018 13:38:23 +0100
From: Roman Gushchin <guro@fb.com>
To: Vladimir Davydov <vdavydov.dev@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] mm: introduce memory.min
Message-ID: <20180425123816.GA3410@castle>
References: <20180423123610.27988-1-guro@fb.com>
 <20180424123002.utwbm54mu46q6aqs@esperanza>
 <20180424135409.GA28080@castle.DHCP.thefacebook.com>
 <20180425105255.ixfuoanb6t4kr6l5@esperanza>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180425105255.ixfuoanb6t4kr6l5@esperanza>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:a2cb]
X-ClientProxiedBy: VI1PR0902CA0036.eurprd09.prod.outlook.com
 (2603:10a6:802:1::25) To BL2PR15MB1073.namprd15.prod.outlook.com
 (2603:10b6:201:17::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1073;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;3:RLEwNQnzmTLGwRlOs3L0NDU5xdfoayT3SsWJgXKs9NHJESeC1yL+o7LrURqyjD37zdG7IVH+3AQQ0ai7BG+G5ohltl8KFxCfiuYzr8V7M05+9P4zbffhy82Vi9gHeKqfEnOI5IdFRJcu/BR/2mC2hU2rNqAtTWEtlYl1gf8o0sQyn8WKbX4X20A3uSYurjNcD8miraUahGW4Rze0+U6Tzd8x2r2fDeaTtS/Y8nrcPo1yG4aGf0fad56npboeGF68;25:W8ynC6xqbUOUkSA7u9Q+e8j9AbpRuQhfy/cay0h7r6L/0oi9R7ITRzH2m6T0I+bpvMbvP0BzoZI9BjAbrspOpVQTmWPduqCnzwuQhthW3Yzfp9YcQy8PMkn6XJheGx1upvQJivu9SQ49csNxcqhV4wvuHeKEAu1hMy8IXOI3PE80tVTnCWb8JTc9zldI9UHqAJx90lZa8DXeoFXf/WRX4fB9Y9trlj77FPwbbOP09Z6rwGFDVLnW/OLeannhvQow2Sf29tXcRDF9sXIQe4eFgGMQk/HJ2VE7ZTFSeT2KipSrRvBumPbIayN8w7riB2+d/3GmU1N78CRQRqten6S9PA==;31:adEU+5IZcfLOiV083mia2Cy810bAe6TP+OevsVNEEFQa/G516cWmW8xxgst+Jrgw4q74aNIklV9VDyWFHXbOkbHzygLbVr6y0k3Jaukbb80NQ0t836vCNCVLJw6HX/JDIJ2mqhUpO1Sp2y9QtzyRDUnvQNFdWSM5D7078Zo8y8Wu03R/ZkSY/hsDi53jId0+EgdGFtPXxc5+DICuzj/Ci+M9E1mLIheBHQhfgr8dY7g=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1073:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;20:+VSRmpJLDFKuxOAwBq9oYNzvceBKnfgvXRbPe8rPsIzPmDenSFwEgqraS3H2F1jtyxfjW5lSJx4r0VoZshIcOMiTTXwtJH6iFW5iGcMXqk1aETNZNsTdYE6UQsI2WZv8cLnAHxrG0V3dgFkZviZlxEgJNPQdOipjn58zZWmk0Y2urZZYVwwauzRzrqGsMKTNa/qVUtySDt9EcwL0ewM4yuMI6PtPajD59dg0GA2BFH6oOcfGUKmMkb26KEvZBXWEOK65mp9ZoNQCprVoD3NMc6sqePpMl+qpN0RUHnQMlsnRjBNkqVFNvlvnYbhEkHTWwpPhz9fsUEsVh2jbDd7ntDvcoNMX5IgWC3/g82IycK4lhRRb4k/lX+YMXuVTvcISe7GJX4DReuQLI91/XKo+jV2MN0dqdJmiFMJ5O4Pa8aNo+II098JonxMpUlMRlipq5mpCxsiEERMet/aWApIsnMZFh0KPr+Fek40e6tUQ7O/fvJKTs+OFE/Htb2DKv7QB;4:+VbHLT3sBa070b0DpN8+CjVlU17AESaxhYCzckf2iS1AVs7ztNekVkj6NyM95Ke1icrIt1mrNqrDMO0K4nIXSfX8n6wRJoD0EPxkoek7+yofYBQeALYL+0g+jF31926iBx8oX92KrMP1oXFsM6V2zat/ZLgFZ/Lg069wnC3xIFb2wsCuqF6HqW+XIxHZi74Of8KZo4hmzJnOJWq64eNFLL4VbCaXwfLut0xbHi3yF+MYZgMbpz87JrEWdxN1FZ8C77j/5syglShDRKcpxm7Dgg==
X-Microsoft-Antispam-PRVS: <BL2PR15MB1073AD732449A7754050498DBE8F0@BL2PR15MB1073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(11241501184)(944501410)(52105095)(93006095)(93001095)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL2PR15MB1073;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1073;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(366004)(39380400002)(199004)(189003)(76176011)(47776003)(4326008)(9686003)(55016002)(486006)(97736004)(106356001)(50466002)(7736002)(16586007)(6496006)(305945005)(2906002)(54906003)(33896004)(8936002)(33716001)(8676002)(81166006)(81156014)(476003)(52116002)(58126008)(52396003)(11346002)(446003)(5660300001)(25786009)(39060400002)(386003)(68736007)(93886005)(86362001)(229853002)(33656002)(6246003)(6916009)(6666003)(53936002)(105586002)(478600001)(16526019)(186003)(316002)(46003)(6116002)(1076002)(23726003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1073;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1073;23:VX7lSF3na7/aODChNPeNYp/FWFW8c9QZrW8xgR9G7?=
 =?us-ascii?Q?+ST+AtO0mf/JmrX+6KQxl+FUnUSIlYDicGQA7N8ainTKIw6bUcPpJ+H4DkdB?=
 =?us-ascii?Q?92NhCiiyNzouBkVecK9WMxZzjJRS2DKKhYZNQMcUAa3rOv0oqleUb7ieV3zE?=
 =?us-ascii?Q?nStI5mS2B/WjX2P+LjxtyskmhR6n0BjqhJ/H/V7NnoTAB1yD0i9xhUli68TP?=
 =?us-ascii?Q?bFFuIYQFgplDXL893PyvclLLB8f/zG2DeT9o462I1RXY/ZYlsmOsGYal2QlG?=
 =?us-ascii?Q?jV6fB5tXGzlx6eQ0wPMLO+NEd7ADUZWYy+bJOeUA1Mi9J0ajRXSyCB/uEI8U?=
 =?us-ascii?Q?PLpZzkF4rs1e5xophvJ0Dnld6tMkjnn4o7urptbbXbWsw3onTiTiMugkCcRF?=
 =?us-ascii?Q?V+rTFv1zWfTZerFFd3qa8oRIeKjZ89J/fgfVPy1SEZGeAMvJU6QmHEuBpidT?=
 =?us-ascii?Q?/nAkWwEkCn1aWajIyb0aepR+riO8U5ZHLfqj+DPsIve3CDeSpBiOMy8Cceol?=
 =?us-ascii?Q?kCMCXsFxwofQFmRbRYUy1I/p5rlL/M4sT/cyDInDj+Mun4Mi49AKuTMQgK/n?=
 =?us-ascii?Q?9mMf91U5MpnYpMaahSz9keKyGCvtekZFrgG+b9u2FMqYh9NzDf+3VpIOOCDU?=
 =?us-ascii?Q?E+2dswu/431at5BXdhC6CTwHPxoRci16YrwL7qfCuywvR2Ebm6kVDV0nFoV+?=
 =?us-ascii?Q?mGK+B95SeTfY2vaaUWS6/TwDgpOgCbq4wSXphPp9hjAV4XLxHuJI8uWcNzFr?=
 =?us-ascii?Q?UFICH2VnKGj32Q9LjTVvKtkk3+I4bWmoXiiesmQkjZ7QqqZxQPnTSEmj27Ef?=
 =?us-ascii?Q?17JwGoVt2k7lFLsXnrW7i4IfntC0K758jJFKJliTnZVbpLyJs4XNJKeFA57f?=
 =?us-ascii?Q?7VHk+tmBWUxV6uwucoBxKBjC/Tq8Fd5PabCEugh/CXK2M6TmP40lQwVk4Gx6?=
 =?us-ascii?Q?4TF0CG5zYC9V0P2cGBLAzh2F4XN8UzrbexPgUtMjzrKf8QT8MX3ST0x5GwGr?=
 =?us-ascii?Q?UN9d/bU/Xv1U7+aRYHd4mryIKPWPsL+E35A5sr649DnonhYpBWAlPb+wKICD?=
 =?us-ascii?Q?0SqcMMyTea+ZCtTPRs45sXhFxjHKcRXgs9tVhrGKqGCeJITmRqxLxYu0zRLL?=
 =?us-ascii?Q?qbhqP+p9k1zdD06opN/EjCA5EIVLOW+OD5tyTViW8gdchef0/6WqRI+hdxPE?=
 =?us-ascii?Q?UWWHONp3gSNu2N4OqWR7f6z8J7L7/ePV18K5u1yE64VoiHf954gvWPdUze/E?=
 =?us-ascii?Q?XzD52YN7O2YB0Rlexu6TQdPO8w+AbC35Orj9N11pGbtYG+M/HZPBf6nadhip?=
 =?us-ascii?Q?wPKFZ74JJ+27ezl4BXoT+VMkntw6/+2DOwVy7gqFwtj?=
X-Microsoft-Antispam-Message-Info: y1G1k9PrAu7UTW1KObxmZiqtOKV11N2OeE9RBTk4WKtkWejKRNvS7m+QfORKYNaVTd5hZ695Sg90Lg9I9lla8xl5JLnG29ngUioR9j2FiH4hYgKkX4gj+NrUZ45t6v5I9ihDJhw6O1mFgSTgJAeksKqu2IZ4297R47FFmqVRIU9xfwhAtlFhoOrgtcq6YGdz
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;6:QV1FP2Cx4pp+vJ3pvXXgfTw5gWnUbIrR27pKKlqDRKrjmuBKAoGCgICAnB0Ys0apz2CzEJROzMa7rZV3mUXkxFzVwZUUhxGHBrfQO+9gbFos/cXmmHCWyOmGn9gGqg673hpqqz9MtgeCOm96BbZLUfRW+M6aotEkhAOr1cZoStbSZG7H3flpcLVcTDNcCm32GarKU9QiQDHJSvqNT1Ebaiu6gk7PjiuXrGtPrANmLzcfB0ZfrplsL3udcBPBUlQRTl1jkhAdNyKyH3JF/nKOOk6Eqenh6fYvas0+g6wD9J9UMXEy5CNLylXcepl1Cnt0WLp1XcQdQ0St4u7CtE4doFbkhdSmrPPAZciogKQP8COiVmxbtCVfu3Yj4RFvIA3SGOmVPGjZoC+9u0tUZ2KGb6bROZtWz4Ytgz+Cn7ULTQH6/M6EUxWMusUng1DtmhIeX3DvpnPiCrZynMKfDuPAYA==;5:7Nb3IHkG9U+J0LuvyF9FnMdKrmRv9yrkdCguaU02cJqj7vFa6bvBZSZgjFquB0MnXRyLWotA9/dKT4mO77ruP/qL7u/k7m1ySaOb6S+32kmDIi/rIFKhjMQuxlRP+/1TN/iqpTpjUsWJvXv/oYlK7M64sGywV2/IRB1Jl20Jo9k=;24:ZzTtK6OuW7O2+CXo485rSeca2TszUfaeF3cQCzYjWsh18vLz0wKuRe1HmWiqHTQUKv7ynL6UB5ESVZaAg3NkSPBNFeEfhe7Ht1Mvv62J8Qw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;7:Iv04FI0AImYvoqXllDvckM4r6xwohqPcu7NFnNvN8CjKojndJ6lQxiaurnWhrC4PqVTsLc1+L8PcZyFCSheLxicOajG/b0Lq7a1iO/A6h6UvcUHhsMXpyOcN5O+0a47fK0cKVNIu1zG+zEY90TIzVQX5dXAI167gS+0LfHqLcTUVDZcN5ulk6paD+/AiVtOhXQ0pzr41wv4x/zncop+BTqZkoYeihVPZ/qe0EzTrXkRhr5AgGGV2NKk+Y5qBRvEw;20:QINNNOBIPM3oxgniUkhZgit5W/KNhM4r94UgbOTFJ+hEfffb7jvnrIoeZFcDalP3sRlRK+O7VlTTM0k6jR3Gjv9ngWF2d5eXi/2b+YXCaXUaSogUiEBnWEVwvHcheBf7NXDSnFPjoibrgtL0h/rDzmZYJorywL2LhjQv9KaQSIo=
X-MS-Office365-Filtering-Correlation-Id: f6b56e52-4324-424d-00a3-08d5aaa978d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 12:38:37.6532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b56e52-4324-424d-00a3-08d5aaa978d6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 01:52:55PM +0300, Vladimir Davydov wrote:
> On Tue, Apr 24, 2018 at 02:54:15PM +0100, Roman Gushchin wrote:
> > 
> > But what we can do here, is to ignore memory.min of empty cgroups
> > (patch below), it will resolve some edge cases like this.
> 
> Makes sense to me.

Ok, let's keep it as a fallback mechanism.

Thank you!
