Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeDBKkt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:40:49 -0400
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:12462
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754513AbeDBKkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:40:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Mon, 2 Apr 2018 03:40:16 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: David Miller <davem@davemloft.net>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com,
        ynorov@caviumnetworks.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH v2 0/7] net: thunderx: implement DMAC filtering support
Message-ID: <20180402104016.GA24140@localhost.localdomain>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180331.220730.1991017148197107974.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331.220730.1991017148197107974.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR18CA0064.namprd18.prod.outlook.com (10.165.92.160) To
 BN6PR07MB2994.namprd07.prod.outlook.com (10.172.106.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6890584e-1e45-40cb-93d8-08d5988622cf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2994;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2994;3:piXJ1myCPoLpBO4PQFcfXOoHOPt/QGVreyteWRzuGI0cRAfhwyuI/8joFye5JXsQXT1vvvEt/xKmPzpZb77KTSq0OaLZwGl51ddJgglZJAh3qRMhhYIQFuA+XZlYBCZIiKS2UklzqXJhF2m1hlUZyYxsNZSo/sCMrrrdPHXDd3ELq57TjNrUfr0Puet5oSsPSMn6Yldwv3YuMaw1ZQnfh9SLYyTTtPu3Y4f3gUTYzqCci9ORQdkOyKG0CLp/Cw5K;25:sztj+XQf2fGgqf7MSvD8jUI3pjVE85pfKX4loEXMPoSjLXQtusi+bXqSwjEHxICXNEsP7447gvyqu7PdEZVHNHaddFkPDQnGMZTaYC3w+j28YpHmSyo1r01ccvYTrFe/KPNLmDGpLtZY8qbso09tHkcTyJw3vr6iunbPlovJX3EReeJYWdAXvMwZwreGOySOo1w7ELt0bBEMq1HSzQdKf48UW5Vw+LnTvxpvuo5gvLziCix/3PJimDcLp9AFQvhU3PoIJ7nxOejZRZ8HMbyk7z6qW30YORJvJubGsCPi+M+VhWWC+cBoKJBg0uqwJaCOi8FdhFgFMIt4A5oiueSoWw==;31:KePU3hV+LUxkfCvD3I8fRwQqT7KppmTyaZj+r8LR0VQekX6zpN3zpmunz8pIARTLGxoA+KDTzKI9v8lM4qfBPZ7oB2GRjVxlr0nouWznrgEpMhBpssau/IJ5qL7NTICPwV3s/p+vfEdaJ3cfJW8rP7TzO57/5c+chjTvOQF1crDBL6LAQoq+Hti7isZEgXQEmbYvpCZofkJUx82hRcXz73N3gAit6Ecp4PCsP0XB2y8=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2994:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2994;20:QE27iblGIfv8yb+qSlci1K0s8Z44MV3e7cxsCuTvnJsV1d0yzreyep4wCbsweVPjwNYCmq4Wijt+/YFAGuy8hRhFB34OsyzshWC5/jymm+G/qPCM63NOsPH8b5cz/eHNimGSk428ql03+/eM+LMNjKg1ETuBK4Xr1uPc92gQfkJSj/lYU+NdhgCn6p53rM6k+sN7H3/iFM1f8+DwkBs8O4tO2Ee9iULCAzckXUFJM3Eh1Cd1zWNiyWvg4/UWihFPaESfbv+BRvvOgz5kL2wWzOA4z5Akq2GUO5ZeWT7JRBAWTGagwgYsFtWa4SuWhP+ESJhgWM1EMXy1ZxcHVApzWSgIZs4wYxBJNVCIhr67/0b2+QMRHg1GMtdese90dllZtz9pJ7rT/uAGJErotiOeRUT0ekWxF+C1m3f4eS5VU3+2cIhwWwmWB/nnXrS72YZOjbBM8ppmTFgecy0QgDKZlBFsi9CIxcw792B/PGcQS6gnmw0p5IOvGYSTfEU79hScxSICbw8vZlsqLsJuhVKieGLUWMzm3MNMpsjxbi1p/gdvF+kTYTKs+9Osic+3IrZwIVtbWzJSuGCDI1Dqp23n9o+93I/nXLJxOMHLhIkddBs=;4:C3iWrLyXhEX2Ge29TgJhPemv7GW0mxZmEika4qf44ij3yZw7pwtTiJsNK0txFy7nzze+ivCFmdDaSmgo6RfE/X80T15+c80S0mxj3PZSXNP/Qr1F5ryQGDjL3d6vFiX1YDwQ8xx+ELWWkpaO4e9EvbkExnRtPj3keDOO4SJXYJf5CLmXrH5G2LJhtjAIIVFyZgDsToF3xyKKraGDtOlE53LsbmoWeVFeAwocmZGpFj+WU2xLDcImlXYSokvX8lqMVw8dgW3tLZs9xS79tkmO4Q==
X-Microsoft-Antispam-PRVS: <BN6PR07MB299429D3B7F72238A2A26AAF8AA60@BN6PR07MB2994.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR07MB2994;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2994;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(346002)(376002)(39850400004)(366004)(396003)(189003)(199004)(61506002)(7736002)(956004)(486005)(305945005)(52116002)(7696005)(316002)(76176011)(105586002)(16586007)(11346002)(2906002)(59450400001)(476003)(3846002)(6116002)(5660300001)(486005)(97736004)(6506007)(33896004)(1076002)(23726003)(386003)(446003)(47776003)(106356001)(26005)(39060400002)(6666003)(72206003)(8936002)(6916009)(107886003)(50466002)(8676002)(42882007)(229853002)(68736007)(53936002)(4326008)(6246003)(25786009)(478600001)(55016002)(9686003)(81156014)(81166006)(16526019)(66066001)(186003)(58126008)(33656002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2994;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2994;23:Gyw4Tgr16Hwpx7HZ/7E/tlWh4nL1gMrE3je1kf856?=
 =?us-ascii?Q?JLcIzm92EZHFEo3yfX6X33OqHvdCtn9WZ+Mppv3uzgNVQV4uxwwpM9uBjdxP?=
 =?us-ascii?Q?wI70q0rlaH2xVqme2WHbhJ6TSN9up8jbIkw4vk4WjRagn/yqgwtnd/tRqfw7?=
 =?us-ascii?Q?LMrxs/kFCgDojcor97dv5izSjd+MgQj/670bpbmYqRZ7kpaA8AKsRHnMdM+Q?=
 =?us-ascii?Q?efU/WRnJk8wCKIcz4iuw0JDOIOp7l7mUHY3DsV1j1K2x9rypXsLpJ60jWgoP?=
 =?us-ascii?Q?4CiASHVJ0gD2+9mV3qRPewH+H0lfvoZSeASs9uyXargV/Pk1BmmsBknPD4K0?=
 =?us-ascii?Q?Rylm309d/FG//zOHJ6a0bUcwOh1Ebi8kaqZSJqouK3FZMOUjgyY/HwdZeo+d?=
 =?us-ascii?Q?2nwNOk7Dk+6LWIlEpjEdDskfb02G5e//WZp3sae9rLKNmJ6vNKg8w9sO/TuE?=
 =?us-ascii?Q?O6alNCfWvITlJpceE45Vkx7Au02mFZIwG5BM/+7NJh/2pm5nm/amqTX8oEP+?=
 =?us-ascii?Q?lK/12jRFb/C6KsA7MmlvlOSmBBlM7CT+Dobb4rLc4NRWwoaQznQ7Dpjm8uHO?=
 =?us-ascii?Q?8AibDwMX+Gl6a/10QpXmzKUg1bjSZcWyIzPMUXCKtiZsNC6ARulMmL1ywcKC?=
 =?us-ascii?Q?9d45bvniRbRpR/6dIk0JfkTaaFKTpJ2VTHl69JIb6PVj4VI8EWabRPFhCBhz?=
 =?us-ascii?Q?hmkuV4ZMFNkpT3jzUlFCiP24s1Ass/3Ud/oJ++TkOj+iFNrzfilx+wsPlolt?=
 =?us-ascii?Q?u2vhh2JgqiQ+4sTQK6nQQMH4rKYB2VBXpp+Olw7lkif/IPM35jJ4EdxXHTcQ?=
 =?us-ascii?Q?u0UlA1IGjTpfEJLOLfqjIBL0OrhalxAsF9kASroEl9yG0tG4WZYu16CDFd4J?=
 =?us-ascii?Q?80OcfhDujDunoyZgCKyjuttj+7372YPvSP8RU4IU0JtIvYOxIj0nqSFKRQk/?=
 =?us-ascii?Q?93p9F9HTd5uGSaALYVFwen8r8eI7JSgnYCXDk1lRizxrQ5XOlCDTN1feCIt6?=
 =?us-ascii?Q?JlT2SAJV3QkRBQW1udOMz34EfIGBqA1fKG5hEl83uC87VaL+TuQQkz+X7XHW?=
 =?us-ascii?Q?5Mzn4B4CPlOC+fngl0Fon3UfecFDvTb9Ci59XTna0E31jJUGgn6U4eCKGL0z?=
 =?us-ascii?Q?7MeOudmCIGD91J2Zvl2ybBeruuMQ/lu852YSV6tJdgaiX2Nt/B33/h/M5aDX?=
 =?us-ascii?Q?m2mRuTIhQ9aDUbhSEr8dtyUMITCc8CSKka14dmcfr2FRZn91dXtRPj4nyi8V?=
 =?us-ascii?Q?kvXAvZFPyqo2ir3XiQZB/uLxRN73ZpcsooQm9B/l+mTJnHLNke9w9MnZk6C/?=
 =?us-ascii?Q?LyFHF8cFTuwb5+Uf+iflj0+q1bM7hlkTERIXp3jEjYUW1l6MoK/z3PmWsMn0?=
 =?us-ascii?Q?tdfvMhNVTqewcjFtaIigJYJ2NTCCYTUAcD6sbkNIOJxvg9oAIG9B4JfF9yfX?=
 =?us-ascii?Q?PdiOjxdyg=3D=3D?=
X-Microsoft-Antispam-Message-Info: Se/N7ShWOkXteeklanUdqHTasXbFJpPc0SGr0ibuovJP98/zAsy58qeiAMBJdoLcioQ4s/9y38gD2PVf8fAQrZk2P3e5fvR509wqmaLWuzEsDou/XVOzw0SR070ih6IkcKDuiai6Jp0FfB8H9ORMjSgvXIGOJ/U3RgslpbWEN8zMCfmr1ynpzW5fscz6eVlb
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2994;6:oTDXBMmNWzec/pjoPJrjw7eNwlME8J8qA5xb9ytyjyJNFVIaix+s4lLMfOZw4JcvLvFu0+RWaeuXxun8ccdJ6xV5JoiICfp58KtJHwtj55Gpeq1c/rZTlLhCVDqD257tT1brXVQWdS3mJGmm9wQwefCYj24s3UAJK0Wzxa+VwM6teETmyGFt6YKmL7VTCWYTv4Rli2RxUGcOF8erEOunoVbLerlz4RGwb3AEdQvOKC6i1CLyMXqavMH5lNbC/aEurQjFDycIfPA4aFsuD9ot7O9qAm0j9Tw0QxMH3jEcSbS0tjl/dNr9NkjUA+bapU5dm9FXlGgt6z5ZS7Ob3R4Z6jR+b6Vx+acz4AR09IUmoL75+FteJXVgfq124CDRRqRgU25S3OPvRpwEIDdvbMtzi4O53G97KBbuH9JN1uP9dV5NLLFulCZzMhozuk1OVaJtYTEwsJZy+1YtVJsEp/vnig==;5:G8zT41hbOzTFlqjjc94sxuASbxPXvAPsDqyEiEmUWnwEhzVYClcKTGBSJtw0/kYWGCnlpoWAQjOTOYTYzbRoHS1z4KWE5qy4acRN7fn//HB1ofNzxvbNjorpa7vXsuWPjz3qnq23hQFJnBuK/vGNSZG84FgrwEyF0ZowwML1IWs=;24:b/8JqD26wzRqVMUTMQUpqyde3noowH18m4rgHS9OOazoU/a3gQ4LrroMDSQhqm93dmziNZQ9eCOVhvaW8dem+nd+Aw6UqNCz7G1w2mLSkfQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2994;7:gwIPN6ypcmh8EgedecqzkpHBpprcVkipHfky3hZdhSkAtiE8vphUs+5o6lcyOZ5XYJQQ9WNshklKD8JQEb2tgb7G3AZxbNiAJ2VErx7bmKu7A3sKULNZesyHlG7v3D0x7zC1rP6IdD9bHZc97DtFNGbqhDhg00fQ5AqHsX6e106ahZJo4wM4yzuq3T0vf3RBDFzUy3oeQjEgv8yLbmhjVDE6LrDaRBcjTaKi/qsSg8lH07Vbzzg6P6iM96IgNXUN
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 10:40:20.8142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6890584e-1e45-40cb-93d8-08d5988622cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2994
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 10:07:30PM -0400, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Fri, 30 Mar 2018 04:59:46 -0700
> 
> > From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > 
> > By default CN88XX BGX accepts all incoming multicast and broadcast
> > packets and filtering is disabled. The nic driver doesn't provide
> > an ability to change such behaviour.
> > 
> > This series is to implement DMAC filtering management for CN88XX
> > nic driver allowing user to enable/disable filtering and configure
> > specific MAC addresses to filter traffic.
> > 
> > Changes from v1:
> > build issues:
> >  - update code in order to address compiler warnings;
> > checkpatch.pl reported issues:
> >  - update code in order to fit 80 symbols length;
> >  - update commit descriptions in order to fit 80 symbols length;
> 
> Series applied.

Thank you.

WBR,
Vadim
