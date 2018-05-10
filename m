Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966621AbeEJRFl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:05:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966425AbeEJRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:05:38 -0400
Date: Thu, 10 May 2018 18:04:16 +0100
From: Roman Gushchin <guro@fb.com>
To: Shuah Khan <shuah@kernel.org>
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        "Michal Hocko" <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, <kernel-team@fb.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/cgroup: memory controller self-tests
Message-ID: <20180510170410.GA30242@castle.DHCP.thefacebook.com>
References: <20180509192016.24944-1-guro@fb.com>
 <72680d54-a0c8-434f-e95c-ab8e4c7c854b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <72680d54-a0c8-434f-e95c-ab8e4c7c854b@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:5477]
X-ClientProxiedBy: AM5PR0602CA0009.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::19) To DM3PR15MB1082.namprd15.prod.outlook.com
 (2603:10b6:0:12::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1082;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;3:mEHQ8l0PNsBPwxeSdbZezyhj/8c4pKy/1HPaOEOiO4aXupWwHYUWHGwF/3XzjUgFNJNW4XSgTvyN4QeJHfo24LtiyLueyNXxCJoscKKwYnRRxm64X0X1IZapIP2UUxeFkML3RwNamAN1XeCpO61MxaQrWg2HkWxjF02b+1/XQIadGtSCFzx+iCpyaJr+6vj5qMQdN6uTWCDR7RJbgG3INuUImZ6fAElG3N9Fzfg3YqW76DCscjWVjdRpZLmnS5E8;25:LDrUrWF3xGU1oeNItiKFKXC1ACH8bQNXuMVvhvsx0AtbIQmrQRx63tfoO2LzAvGhax/v1DVgR5ovReezuoylh30vWX2X+ms5CN2M6+p6l2cc/K2LLiUcwnGNj2rzPLSYBjyfEyp8YwfiF8F/kI8a4XdIUcK4tI3iEvADJAUkHf3Bg/7HnVU+evyxXZ/t2TjYW99HhfGUkLFsqFtTwQTXVO2oZapS/hQ6XAixMAj96UAkhvKS3pjmM7QeOb1wNLTdHoDDU2CS6a4/z9p92N6v4XoscsvOBG2RcLNhjuYryD3Pq9CFb3ex7hLF9AhAByPXxzj5PIXlAozGd+57CtzMfg==;31:kV7Rpv7viDxk7mqhyqle08LVYuqeergE6KzgpnK6VrQEkkNQuqZzXw6DCbPA6+DfH7ncLeQ+/RaMjyK1Gnl0smDxMzzLHi64PUUOsVY0MjLETWMPaYapVsJc922vuaWo+//NwNyQjuAf7WbqIj2OoztymMC/Zff0E9l/c4gQjTGEHWvJE1CB7DnHsOPf+jXDEK3f7vu5lhJFSKsF+d/PrBqzaPv2sSgDUvq1XLV6hsw=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1082:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:5hvuqCGWGHRp7m1FbHvtDXsLhue3Q6dCY+ysL/RAjtF2c3JNX1AqBzvKnTgFlZWRYguIGpi52nJ3K+DkRDJLospOvi23xRCnyw3EtttsCO6tNLGL6kYBg/+lhhLpUd7znjUMcNIL8k63IvP6JN3tiR9K0cAEMi+hHj2/M6czuOKt0oK40GGc1TICWcE1dE8x6HhZAfwJ6taEGMn1qRryOne9TW2gqTBaBIjQC6iZfJLw1LIAYM45cxthwcp9r+WByvlUO0hbq+a/yXJerXP6jGim7exxPB92vKhTx5DHYGRjoyiwZ0kgf7I4lAasveBo8w3ZwGRsJ2m4MPjseCJ83Pdtx/jHARNaBH9TkiAB/0NVPGzUsArP6IhdXqpDHeVbdPkTSx5q/Br2UoZ5D/QUbfsz5EHbTQCMlI+4i+oFQDIC1gmb+kP06apWo0cDN3zH2bbrAnFHzv8u4mdWN5EKvLn1HC+bdDuepMPoR9c1eeOttxGZWxtLgSuiZT6vQf0N;4:Mf/IqfUFZC5u8sWGoeyS6So8Jqb7tRMwMrHtpEWeGmOBNPhItuEM6NH5H7/DTSboBlJ6BIZfLHO3nhwM0mFYntlf/M6JnaaM3Dip/PF/8cWMyL0wHa6n/B1cDFBMTqjcmQCUxVKm/RglgdKi+wtPyPIn7N/31+Lzay10zLnZ/u3doqrArzfN65YibVPnOW0zZ+5m306eLNHwCfw7Cyg7oVJkqhjfIv1ykEs8gKwBQChKDFL9sDEoX8ccYwuuDX9jnw+KUgnFjQGKaweSkMdCiw==
X-Microsoft-Antispam-PRVS: <DM3PR15MB1082103DBE09510572C27222BE980@DM3PR15MB1082.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM3PR15MB1082;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1082;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(366004)(376002)(39860400002)(396003)(189003)(199004)(305945005)(53546011)(8676002)(25786009)(6116002)(7736002)(23726003)(47776003)(68736007)(33656002)(81156014)(7696005)(16526019)(8936002)(186003)(81166006)(386003)(52396003)(6246003)(2906002)(478600001)(52116002)(1076002)(76176011)(6506007)(345774005)(316002)(16586007)(53936002)(6916009)(229853002)(476003)(50466002)(97736004)(86362001)(54906003)(486006)(446003)(105586002)(106356001)(11346002)(5660300001)(6666003)(9686003)(55016002)(4326008)(46003)(58126008)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1082;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1082;23:dwulXzMkUy7Bu62m3G9IYX7AgO4eNXzQ6KjqIuAGb?=
 =?us-ascii?Q?l4dwWBo4NRvbLYjXZhbxVk9gNad17arTrVq+qulDWc8QFgJLjDTL5gScFExA?=
 =?us-ascii?Q?toTVOgQu1vQe+j3FshxJQSloY1CqE5NThv1syrUj9RUXaax0jy3mW3tFhhOZ?=
 =?us-ascii?Q?2OjKN1ZpFqMhDZWYrUN/fIDqqfCWEz97nT/4rkhOG4IqZ7q5MCbOZTP5ugGR?=
 =?us-ascii?Q?rtyadA0MMqnvGJ/7PlM114rLjhO46DaFNCSqAjRIu44nJZ8oOYG6DUKBT5hk?=
 =?us-ascii?Q?58Y0Xynfb19PK8KzUJZSU0Wei5/1oC6nAb/hfl+govdT5DSLFG4qXAOhntIY?=
 =?us-ascii?Q?gZ+BPVZXgXoxuEuN28fqj10PAGizhDkQYTs7Xykict7+wXrmC5R2Al7zRFPv?=
 =?us-ascii?Q?lwNgnsHgmCgbV9qCvYlJJ6kGVhTRI9uhfI0CZjxegbFUbu227165MDDQakm4?=
 =?us-ascii?Q?gueucUEyc8Cnio4eheUd2fCUxGWECHtysSpj3s3TARSYvOxxG9P3ofTfZSFK?=
 =?us-ascii?Q?A+idXe6dD2DYcPPz/vrjCLl39741pj+swvCWVKbBF7mHyF/8pVKFT6GXi3Ek?=
 =?us-ascii?Q?HKyOL4F30DTC+0tNQmibZ3XVpkxCrYI/j56D/smXfjFu02ri5+8fDAEZrM21?=
 =?us-ascii?Q?n/dg5HKiGSi14MbArL4b+RSOILngCPdB8naO/ubFz2D+Znz0XVKBjQNseRAl?=
 =?us-ascii?Q?+ZkO8Phuh7Ibr5kX5hjWwX7/vwAHqTFJCQR1apx0XY7T+5JhZcBGiE7ex1oa?=
 =?us-ascii?Q?HXEaM2JeoqugIv2rr/T52JhQi2LBwNJI6lqoIWXHWfOr5FuDRrWK9yND3/n3?=
 =?us-ascii?Q?JDCB3m6sN4TSZO5HHUK4f4G6YIZgT2if9JtipmY/Dpqc3JaF9EW57cATY9hv?=
 =?us-ascii?Q?5Hb3Qmb1S7Hy2VC9u/F/LV2Y31EUGVDUUygLGXgqh+dv2gFa2nWS4g0pz0Zl?=
 =?us-ascii?Q?4+LtbCHsknz59uGBqfjOklo7Zbsn6LE9CUKrLhUH6Gcr1MB2oCj7k+i/1kBb?=
 =?us-ascii?Q?QfVG2tMg/WGWhsm2VfTgkM+AC02/xUXoVKsu+v4iAsImAKCSiioJhEcde/7T?=
 =?us-ascii?Q?tM889rgk+WHFYXKX8IdEWUFFgKcsS9J2ueCCsKN8nGwsHOOt9atKyj4zJFrQ?=
 =?us-ascii?Q?+4HcVYyQFOmeRbH86gmMlJtASry1lpcHst3wweHoqE5hW8UfGHkH/c9cpTZh?=
 =?us-ascii?Q?fpRTanRjyxAnHur/MQjC9lIu3hiddcCI9POkc1rIK5/KlL+h7D9yN0+s2aX1?=
 =?us-ascii?Q?PBQhdAe+gd9RwXiSnhnfWy9/A9mHNGI8CVlEnVKP4eHVUZzcWKwLoJ6XOYd4?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: rYqFtlOqMGHxYJhhvRcYbYrFzq0v3SYndILQ6JmhKUR0De8j4a77zVfuVizrh2QSrzoVx5acAzRwB2mbyxFglXHOD09R/Ae71kxnUuiEZ9NUzPuyBVl4WD9aRcr1kmJcdwnyQeLx+BC2X9MF4T1DOtmFlFYrHncQBu+erfulQ4WYT/jrvtH+S9nzXfsbgyPI
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;6:xlItvx00yQ8ssfbp7SYMqtyM5Sg7beLG6S7L0XTemKjukHRFYD6W6+X8vYyzxIHd3Pjr/5vv619gH63LYVDXBBJXIA2h7+3JmZIzyeZAq+KLwQvOIW/EtZm7yboJ3Ogag5+7WReSqQcegeV60FHtqRxzSC1ITIlJwCPjo6HaHUbJOLU6OOdl46/EmIl4dCsBPSWaOlQ5CCnkIB3sME5OUV/LV97whhSDx03LkhFLYG7/rTkDSgsF0u6C1gqF8iSoH5ceMTdJDkvjJnCJaWWlz9VmnBGokYjrvn4+jKjqcVuHKsSN5jYyWaB6Ui7wghobh0UoIZL4tThP9RTcRY2thKo7sl7Ke+dMd50gILtTXxmdG3FBKl6hf8vjnCvlJi+rz6JWIVWAKcR/DeiMXjor8f0pUfX4Q5AHujhb8cIPsiyEPPYyYButdHzoWptIdZ23vCNj+29ZG3J7vosuobMBSA==;5:cKCvm9SLEAskSpdD9i3tZdQefIsFK/DQ8tHERXWvP/2ZScBtkMWgr8s86/xjxR+iGpK/xb7yqNjEPRT0bURKmrEe35+DAvqA+PRps0FkuSC2za1IgC+vvjVlkasU8IpUg9aV3B82ygI9v6YOzMMGpdXgRFR+YOdgU3UsA8pfxEY=;24:Qug93prncTd/iE7vmLWP8sYua58JS2rDo833T5k6xP5jqa38XJEgAqdDq4j/2I2CQdfjg5eHLM6Fj/sxni7k2yk/bwFtBRj6Fatho0uHEV4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;7:WGllbJziMmGrrGTT45G7p6D4lo3olkW6CeciF8T+WQwDgq9Agax1qJAzOSNRmX+CTeX2VQIy2QWBS6knQ4vxECwWM25McA7n2fMTqhJFC2Vl5T/tzzkKGZLl+YnbnSV4NHBVhNvzib9MFNyXYtuQsNKqjworp6PVTXeP47L6i8CTfuu6JEk0YkBoJW/K/sv1IiX/yccoLWBNxtTqSnU42yVW9UQi8D2kW8TTlf/oy57ofqpBFdXeMlN+jeSNhk2N;20:tQ3rnCqW74PIRUygw+TTpM7/VfDehGjZjnybpjWdR42w1HzLSBnz4hOELuVE6CbhKjztSzob6UpMgD6IpRg0uqVcdARrKt+/x9PUNB/IE/pSpkOCvvr8mclaB4ZgkJsqqtULu7lFJIaL+OM1e1N4wBNp9jlOa/949wxHhu0mjCc=
X-MS-Office365-Filtering-Correlation-Id: 4fc633d8-4ee6-4b02-3f83-08d5b6981651
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 17:04:25.4750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc633d8-4ee6-4b02-3f83-08d5b6981651
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1082
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 08:25:06AM -0600, Shuah Khan wrote:
> On 05/09/2018 01:20 PM, Roman Gushchin wrote:
> > Cgroups are used for controlling the physical resource distribution
> > (memory, CPU, io, etc) and often are used as basic building blocks
> > for large distributed computing systems. Even small differences
> > in the actual behavior may lead to significant incidents.
> > 
> > The codebase is under the active development, which will unlikely
> > stop at any time soon. Also it's scattered over different
> > kernel subsystems, which makes regressions more probable.
> > 
> > Given that, the lack of any tests is crying.
> > 
> > This patch implements some basic tests for the memory controller,
> > as well as a minimal required framework.
> > It doesn't pretend for a very good coverage, but pretends
> > to be a starting point.
> > 
> > Hopefully, any following significant changes will
> > include corresponding tests.
> > 
> > Tests for CPU and io controllers, as well as cgroup core
> > are next in the todo list.
> > 
> 
> Thanks you for the patch.

Hi Shuah!

Thank you for taking a look. I've addressed your comments in v2.

Thanks!
