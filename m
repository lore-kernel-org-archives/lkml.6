Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933770AbeBMIlm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:41:42 -0500
Received: from mail-db5eur01on0131.outbound.protection.outlook.com ([104.47.2.131]:3256
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933631AbeBMIlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:41:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Tue, 13 Feb 2018 00:41:22 -0800
From: Andrei Vagin <avagin@virtuozzo.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: tip-bot for Jacob Shin <tipbot@zytor.com>,
        kirill.shutemov@linux.intel.com, linux-tip-commits@vger.kernel.org,
        tglx@linutronix.de, willy@infradead.org, gorcunov@openvz.org,
        bp@suse.de, peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@amacapital.net
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Handle 5-level paging
 boot if kernel is above 4G
Message-ID: <20180213084121.GA19906@outlook.office365.com>
References: <tip-b4b56015ed1c98cbc9469e35ebbc4373a2844030@git.kernel.org>
 <20180213065155.GA14087@outlook.office365.com>
 <20180213080816.vwh64jiz23frjiot@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180213080816.vwh64jiz23frjiot@node.shutemov.name>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: SN6PR0102CA0002.prod.exchangelabs.com (2603:10b6:805:1::15)
 To VI1PR08MB0749.eurprd08.prod.outlook.com (2a01:111:e400:5a04::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf0f2e7-a95c-428b-dbda-08d572bd984d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB0749;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB0749;3:vlqEuZWC3F5QLyqNBDyvllPcw4wEDIXtOilXD4DykCUMOXn9TkueyE/WEkl0tjEgYSHto3ry0BbfWHYEOStj8HXDmmVDI2O+9wgQcZuC9kGT6VM3OOWZkyhzpSP9OiIwf1SNAHbUEEsV+z1l9yuWKSCstjozTgmaA45PqhS5che++REqY+GgXTB2ZKeKhcYO6udk6APYclYPn+IMMM96z7aLVjQknkmi5OPq2Za6abicTWzh8oNb5xm2gLQ+hMKw;25:2hBwEeLA8Ms0yr/7i9B6tzMBYfGax61aIoHUoSLDY4FSiXHRGlX2U72cLIFFWTWtNWML9WzJWsdqtbmkEFXEBlI0BeknSDeo+f7VZEP2pljEA/jfD178JDjVbzPbhYAnYWWPkeHro8S963FHjzWzcfWp/szAsWXuL2M9+Lw5LjrWff3LH7ld/hVIHyMRalUIRet6G2zY0yb3UtN++XMWqpRUIEyLFL/MOxm3kHoOOsDF5pXyTrhRYPW8kdlmOhkNTekgJzYKKPFN7250rHDVr+YR4vHRYyuN9zUc28mRzCioRuNnz92IkJvF47gombOYH13wsigixzeesmgykAxCJw==;31:WDEvIRoOX0kHbqV8tj41r64ngv/k/8D2FxgM5YQqeQ3yUuFO5Yu1fdL3oWHDZXwLYPXvL9++azJsASEGC8COEWwsTyTMQ42VgQ4aylVWXPfnePrH7izThW726LOeCnEhDrSeSByyws3HkJbfHDsAWTwllrvlrCtQRyYImLtbcTQMWbPDiMlyzoNvvALGN2aC0nJOhhs/p5bfQFyTBuf+L6JBePR1U7AUQ43jzKU5i9U=
X-MS-TrafficTypeDiagnostic: VI1PR08MB0749:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB0749;20:1SVR3nDWEWGGK25vnJ8/Dr/9xvpBOkRk0SRvwIC1WMiLiJ6WpewHJORSbybV/4bP3g2oDg3nngepsopH7P3BMSJ0Px54MRICF0Qy6TPe3zksQJTVH/4zjAh0MOeLLFe3qx7F98yPc2dBot81RmFWd2ezoXsWaHM5Mh0Y6EC+0z+uCcttGnmAqblvtNDpoP9VbSiZcNQj/xUQ+BW68We53NdnP5y7ASYrfJlj6jpoCWje0Zb8pSxuXVfS8ovS1klRygdrFNmE1Z/5Q7Vn0CElzuhyUe5gIkMaiHwryV0u4iyjWiC6W2ym6cH+SBgt7CpjiwSL1mWSuKsFkh16hRAY9IBlrmIni9LNyDty0GE2jqIBxKnsjW76qd9ejf120i3y8iNPIaI9dVlqeg8YLUz7Go9Nj/JqfWDJCNkOt0CDNQY7PtiJ92qA78r+R70qQIOas5nEVK7KdrwYe97flIQXWLHlrD2lJc4oyJvDWXRjYtwIx+4B+3Om5/UeO98QAVuJ;4:IkMRxSdCju3itrv6ARq4/XD/RkSFNCap+8KfspDI0UIJuduWvhsetC4EyOqBQcI69eahMUDZVdl+vWkIaio+JdsVCFkDwGiFqGcM/yYC34EPp1qB8CFdq5Jb9+rWnoiI/7mx+XOMqxqJk3dFICMej+8PIJEh5DJIm+v5VnQRGa1QFbPpcj0bNEZFYAwLIpxpyOqpjn8bpcGRtQKYtHme/2coFuPr6HtbGOPkV8C+lC+7FKVTv5pznuAJxOuQLLOgqQJ+ot/Go9FPEpA+gkC1XA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB0749B823142C2CA741B01C82CFF60@VI1PR08MB0749.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB0749;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0749;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(366004)(39380400002)(376002)(346002)(189003)(199004)(50944005)(7416002)(33656002)(4326008)(55016002)(106356001)(316002)(575784001)(86362001)(8936002)(53936002)(105586002)(9686003)(7736002)(229853002)(3846002)(6246003)(23686003)(305945005)(6116002)(66066001)(25786009)(81166006)(53416004)(81156014)(8676002)(2906002)(1076002)(386003)(52116002)(69596002)(7696005)(58126008)(76176011)(59450400001)(16526019)(6506007)(478600001)(16586007)(68736007)(186003)(2950100002)(6666003)(5660300001)(6916009)(47776003)(83506002)(26005)(97736004)(50466002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB0749;H:outlook.office365.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;VI1PR08MB0749;23:FcC3on4pg425Ibk1uudIv0YY5Rpu6PBbmUjzt2ZVppB?=
 =?koi8-r?Q?z0d0UnWssUQZ5nnMXAUgZK5x9zu3MaBZqi5cpBSEBNC3TQ438wDE88PAEpwXUt?=
 =?koi8-r?Q?C4szorjW5oWRMo9zU0J/brBQsf+0Xc6/U31kSmA/LMU6Vq44NVJzA1cx7hT6jV?=
 =?koi8-r?Q?oS2lmYCUsDM5lzFf9S9P+vyESY+vxwDNMPXJwdM2s/NF0dVmEpiCUdX4/9w2B1?=
 =?koi8-r?Q?LyZqJ7oouO6kiXSNFRxi/6PVM0Z2+fymAAxzJpV1OG/Q5UpXH2M1BBZJPsHqxI?=
 =?koi8-r?Q?AIsO9rsk5nHKUbzIurXoSJD1IDIEnVhp8N1HiYOTehrGbF4eOh9+5lnBIprACV?=
 =?koi8-r?Q?zoqKiiQarxnb7kGYhfqzoRa6RW/qL5CaKlpEbh76wwR7Uk0xDJlff9YQdOTJCp?=
 =?koi8-r?Q?JQ6ZudGRmgqZJkkb89RcQ3L7YymtaGco8175qX4RLGuzusKwpKp4GLjaxPnFh+?=
 =?koi8-r?Q?F0LOCBQcZEK0fpg4ehLkA2TeayFJMPMLFM333KHLHslswWJCA2e8Zgw3jrxygz?=
 =?koi8-r?Q?f9hRPKoYbA0kN1FEFRer6NRqf4rYnuJ28c1I1fvO7tF33u8KQNdVYwZ6+pmcYy?=
 =?koi8-r?Q?WMD8HC17nxgoK++YwQpslBTx3cJxRieCeF/NiWpEAXewTXDchZoruSuYRMImZ2?=
 =?koi8-r?Q?SijbAnfGF2AZLnzYfPbOFYxMeoLVJEBOhcWWiJMHbr/m/V0AFTrRbiBlm7Doe4?=
 =?koi8-r?Q?GN6nuEZIK4G4a1a1xDr+qzPG+jqo62/ImzRa1MQijxLZi9EhZuqkgDYsKdV7t0?=
 =?koi8-r?Q?9ttuylYLyVY3ZqVFnm+XPLB2orMXkHqvzyqRuqoKUbpTg8f1UjJioMMoeVzav0?=
 =?koi8-r?Q?RvtzIrSNS9rK29QJAuiFcqbPhQjNEJi8FOe5YNk0lJ4keL1gzuTqzSgAOo39rb?=
 =?koi8-r?Q?q29Q/Tj/mASKYTnHMyshp4p0c85xkL9xSjkfQsVFF07WNkDLCHFLgSP/WaqgYJ?=
 =?koi8-r?Q?JX6IMDmeJeTUafhHMIaZMU971cq8TXb2+W1cRXgs2dzqm0/fe6Fx6MeZ/wfmPK?=
 =?koi8-r?Q?T+yzuKDSX4OpPkIRxZAXCf+y048YarbZ7QLZMIV8j+UeDVWQFujlDxUMZ8lD8D?=
 =?koi8-r?Q?xkqk4mBlvny+aKw/Tn+QRtIM4GR1uum++xezzx7/OkAgdM6kgia++6G3uz7Pyv?=
 =?koi8-r?Q?NhUKysJSA0eYwFn1vC5j/KxdAwa1LwFE3mLqdTCEIvfZL6gqiAgv22syjOQHxt?=
 =?koi8-r?Q?0SXu1VaYSguhYM9CpJlOIvQ60fkZJzQJr8J7y1aCFzQALt1OM7A1zTl0nspDDw?=
 =?koi8-r?Q?HpJQqtRBDl0jFBwyxkTtauHHOmqF/FUvYH/WGFywK7jV4OTv5IjczjrOQxs9B?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB0749;6:n5/EEGdAVxoNUgHeE86DSwH5uNoSRliKZD4HAc36yGOD+JJCzFcJAxzMhKcB30bxb8jZY+S5AJfJerEEVYMHZ8gDNyAyRLhsSDcSxzAh1q98K0Whj3/edG8jZ/D7TZxRrB7cKvclb5tD3IOaXYSZlCt+sAegExQEP6/k+zuj6D6rIRqRphNGJ2Jrb+x3tBrBVSiO1fm+Ygb2nu0yXu+eyq7VpXB9Uewd+tIpO34jsC1g4I7dbeR3dwlmgxb/N8G30S9SQXdvzLwgcYeU+g/Iqq/AKthu/qKryrcOER6gLNQmjscz7vMx9xiLjFI5VjtOKrp0iipdddfRJVTxkkbTzvyPq31KI3O2Oss4a0bDrNM=;5:tGGcnKvL97PSjEhF68kK0kkQM31/MTo+W6R/cixhxPpa6fY30gSR/7Xd7uSlqQedMTpDLu3araHUblZdDoUvBNY40T3mWqwu3ZCmEKDRFRTgD9GYzQj2HdbrgszHpyYErtmS1SM0L4l6GyoLGlKw2Lltvn0offg9m58O6EvFp2g=;24:eIWvfkBq0ZTRY3sJ2jaCovzK5wM+Goik680dpq/jos747sQVLzGk2EINjK1Yi+/++6KQ0VELwgYKrP5eVy0/HjWj/KbvPs5ZWexQneoWokc=;7:V5oFRivAGHWvYdh8xgzQur+L2nZboIud5A1NO4p9bqpr5sNoh6m80u3iWPkeIMR0kb1/Cd1ZmWK2D56vp09CGOPwiyfwIgPlsSRYlAUhBcOcyLhBmDcJxBVXTsQKBzDCtjuW8MU+Uq3yVa5UrD+Y6ioQMuNwhJe6I5/8eye9eymjxGTKQQwfyg7E6lLmDIBhWeFPb+ps25XTGbwGBr1wwNmO6EHCc7FAD0qiehy6Y8MPZ0lwNBHmQbshLHFfbF1Y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB0749;20:TyQJ/88iN8zzWg5dNQ4RBPoqsnws72EJKxUhZSXSZhMpKcZXNzA01uTWU419Tbo3JfT/Yl3xYBpmL7tX0HXef4qUyvo/PPISScWJRyto4ZvHRI2k7U+5wIUOmV6FuG54y4oURPUSPOwJqPL8AXy+6oWvIxJMMzyCzgGN8Eiv+W0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 08:41:33.7885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf0f2e7-a95c-428b-dbda-08d572bd984d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0749
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 11:08:16AM +0300, Kirill A. Shutemov wrote:
> On Mon, Feb 12, 2018 at 10:51:56PM -0800, Andrei Vagin wrote:
> > Hi Kirill,
> > 
> > Something is wrong in this patch.
> 
> Was it bisected to exactly this patch? Is the previous one fine?

Yes. Yes.
> 
> > We regularly run CRIU tests on linux-next, and yesterday I found that a
> > kernel didn't boot. We run this tests in Travis-CI, and we don't have
> > access to kernel logs. I tried to reproduce the problem localy, but I
> > failed.
> 
> Do you know anything about host kernel which handles kexec?


Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.5 LTS
Release:	14.04
Codename:	trusty
Linux Version	4.4.0-51-generic

+ uname -a
Linux travis-job-43f4b617-65d3-4621-bd05-911efa0d69df 4.4.0-51-generic #72~14.04.1-Ubuntu SMP Thu Nov 24 19:22:30 UTC 2016 x86_64 x86_64 x86_64 GNU/Linu

> 
> -- 
>  Kirill A. Shutemov
